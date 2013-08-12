class League < ActiveRecord::Base
  has_many :seasons
  has_many :users, :through => :seasons

  attr_accessible :name, :admin_id, :active_user_id, :in_process

  def set_turn_order
    self.users.shuffle.each_with_index do |user, index|
      s = user.seasons.find_by_league_id(id)
      s.turn_order = index + 1
      s.save
    end
  end
end
