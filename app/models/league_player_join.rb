class LeaguePlayerJoin < ActiveRecord::Base
  belongs_to :league
  belongs_to :player

  attr_accessible :league_id, :player_id
end
