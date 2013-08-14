require "open-uri"

class Tournament < ActiveRecord::Base
  has_many :player_standings
  has_many :players, :through => :player_standings

  attr_accessible :date, :location, :tournament_type, :results_url

  # Checks for a Player's appearance at a Tournament and updates his/her information
  def update_player_info
    # Gets the names of each Player, pushes them into an array
    pro_players = Player.all
    @pro_names = []

    pro_players.each do |player|
      full_name = player.full_name
      @pro_names << full_name
    end

    # Scrapes Tournament for participant information
    tournament_url = self.results_url
    tournament_page = Nokogiri::HTML(open(tournament_url))

    @tournament_results = {}
    tournament_page.css('tr').each do |player_row|
      name = player_row.css('td:nth-child(2)').text
      rank = player_row.css('td:first-child').text
      pro_points = player_row.css('td:nth-child(4)').text
      @tournament_results[name] = [rank, pro_points]
    end

    # Creates an array of all Players' names that participated in the Tournament
    participant_names = @tournament_results.keys
    pros_in_tournament = @pro_names & participant_names
    # binding.pry
    # Associates participating Players with the Tournament
    pros_in_tournament.each do |player|
      playerObject = Player.where("full_name = ?", player)
      self.players << playerObject

      # Assigns ranking and pro points to each Player in the Tournament
      pro = playerObject.first.player_standings.find_by_tournament_id(id)
      pro.ranking = @tournament_results[player][0]
      pro.pro_points_earned = @tournament_results[player][1]
      pro.save
    end
  end
end
