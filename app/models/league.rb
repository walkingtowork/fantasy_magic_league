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

  # Finds the winner of the League
  def find_winner
    # Searches for Player that won most recent Tournament
    @players = Player.all
    @players.each do |player|
      if player.id == Player.find(player.id).tournaments.last.player_standings.sort { |a,b| a.ranking <=> b.ranking }.first.player_id
        @tournament_champion = player
      end
    end
    #Searches League for User with winning Player on their team
    @users = self.users
    @users.each do |user|
      if user.players.include? Player.find(@tournament_champion.id)
        @winner = user
        @winner.save
        return @winner
        binding.pry
      end
      binding.pry
    end
  end
end
