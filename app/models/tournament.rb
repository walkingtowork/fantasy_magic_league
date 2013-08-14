require "open-uri"

class Tournament < ActiveRecord::Base
  has_many :player_standings
  has_many :players, :through => :player_standings

  attr_accessible :date, :location, :tournament_type, :results_url

  # Checks for a Player's appearance at a Tournament and updates his/her information
  def update_player_info
    # Gets the names of each Player, merges First and Last into one string, pushes them into an array
    pro_players = Player.all
    @pro_names = []

    pro_players.each do |player|
      full_name = "#{player.first_name} #{player.last_name}"
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
    pros_in_tournament = @pro_names - participant_names

    pros_in_tournament.each do

    # Associates participating Players with the Tournament
    pros_in_tournament.each do |player|
      playerObject = Player.where("fn = ? AND ln = ?", fn, ln)
      self.players << player
    end

    # Assigns ranking and pro points to each Player in the Tournament
    pros_in_tournament.each do |player|
      pro = player.player_standings.find_by_tournament_id(id)
      pro.ranking = @tournament_results[player][0]
      pro.pro_points_earned = @tournament_resuts[player][1]
      pro.save
    end
  end
end
