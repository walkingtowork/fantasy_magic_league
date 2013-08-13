class Player < ActiveRecord::Base
  has_many :league_player_joins
  has_many :leagues, :through => :league_player_joins

  has_many :teams
  has_many :users, :through => :teams

  has_many :player_standings
  has_many :tournaments, :through => :player_standings


  attr_accessible :first_name, :last_name, :nationality, :pro_club_level
end
