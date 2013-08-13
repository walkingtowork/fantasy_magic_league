class Tournament < ActiveRecord::Base
  has_many :player_standings
  has_many :players, :through => :player_standings

  attr_accessible :date, :location, :tournament_type
end
