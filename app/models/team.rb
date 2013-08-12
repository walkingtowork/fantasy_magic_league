class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :player

  attr_accessible :is_active, :player_id, :user_id
end
