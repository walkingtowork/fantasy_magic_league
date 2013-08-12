class Season < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  attr_accessible :turn_order, :user_id, :league_id
end
