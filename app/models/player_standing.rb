class PlayerStanding < ActiveRecord::Base
  belongs_to :player
  belongs_to :tournament

  attr_accessible :player_id, :pro_points_earned, :ranking, :tournament_id
end
