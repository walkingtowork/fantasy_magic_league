require "open-uri"
Player.delete_all
User.delete_all
League.delete_all

@sfmagic = League.create(
  :name => "San Francisco Magic"
  )

def make_users
  users = ["alex", "erek", "brent", "stephen", "arthur", "joel", "brian", "tom"]

  users.each do |user|
    User.create(
      :username => user,
      :email => "#{user}@#{user}.com",
      :password => "password",
      :password_confirmation => "password"
      )
  end
end

def make_players(website)
  player_scrape = Nokogiri::HTML(open(website))

  player_scrape.css('tr').each do |player_row|
    player_first = player_row.css('td:first-child').text

    player_last = player_row.css('td:nth-child(2)').text

    player_nat = player_row.css('td:nth-child(3)').text

    player_level = player_row.css('td:nth-child(4)').text
    p = Player.create(
      :first_name => player_first,
      :last_name => player_last,
      :nationality => player_nat,
      :pro_club_level => player_level
      )
  end
end

make_players('http://www.wizards.com/magic/tcg/events.aspx?x=protour/standings/proplayersclub1213')

make_users