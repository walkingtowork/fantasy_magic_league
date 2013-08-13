class League < ActiveRecord::Base
  has_many :seasons
  has_many :users, :through => :seasons

  has_many :league_player_joins
  has_many :players, :through => :league_player_joins

  attr_accessible :name, :admin_id, :active_user_id, :in_process, :increment_up

  def set_turn_order
    self.users.shuffle.each_with_index do |user, index|
      s = user.seasons.find_by_league_id(id)
      s.turn_order = index + 1
      s.save
    end
  end

  def increment_turn_order(previous_user)
    if self.increment_up == true
      next_turn = previous_user.seasons.find_by_league_id(id).turn_order + 1
      next_users = self.users.where("turn_order = ?", next_turn)
      if next_users.length == 0
        self.increment_up = false
        self.save
        return previous_user.id
      else
        return next_users.first.id
      end
    else
      next_turn = previous_user.seasons.find_by_league_id(id).turn_order - 1
      if next_turn == 0
        self.increment_up = true
        self.save
        return previous_user.id
      else
        next_users = self.users.where("turn_order = ?", next_turn)
        return next_users.first.id
      end
    end
  end

    # next_user = previous_user.turn_order + 1
    # next_users = self.users.where("turn_order = ?", next_user)
    # if next_users.length == 0
    #   num_turns = self.seasons.length
    #   self.seasons.sort_by(&:turn_order).each do |season|
    #     season.turn_order = num_turns
    #     season.save
    #     num_turns -= 1
    #   end
    #   return self.users.where("turn_order = ?", 1).first.id
    # else
    #   return next_users.first.id
    # end


end
