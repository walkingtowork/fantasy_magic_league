class Tournament < ActiveRecord::Base
  has_many :player_standings
  has_many :players, :through => :player_standings

  attr_accessible :date, :location, :tournament_type, :results_url

  # Checks for a Pro's appearance at a tournament
  def player_check
    # Gets the names of each Player, merges First and Last into one string, pushes them into an array
    pro_players = Player.all
    @pro_names = []

    pro_players.each do |player|
      full_name = "#{player.first_name} #{player.last_name}"
      @pro_names << full_name
    end

    # Scrapes Tournament for names of all participants
    tournament_results = self.results_url
    doc = Nokogiri::HTML(open(tournament_results))

    @participant_names = []
    tournament_results.css('tr').each do |player_row|
      name = player_row.css('td:nth-child(2)').text
      @participant_names << name
    end

    # Creates an array of all Players that participated in the tournament
    @pros_in_tournament = @pro_names - @participant_names

    # Assigns ranking and pro points to each Player in the tournament
    @pros_in_tournament.each do |player|
      pro = player.player_standings.find_by_tournament_id(id)
      pro.ranking = scrape
      pro.pro_points_earned = scrape
    end
  end
end
