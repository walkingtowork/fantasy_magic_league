require "open-uri"
Player.delete_all
User.delete_all
League.delete_all

# Building list of Players
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

# Creating Sample Data

# Sample Users
@alex = User.create(
      :username => alex,
      :email => "alex@alex.com",
      :password => "password",
      :password_confirmation => "password"
      )
# Sample League
@test = League.create(
  :name => "Sample League",
  :admin_id => @alex.id
  )

@test.users << @alex

@users = ["erek", "brent", "stephen", "arthur", "joel", "brian", "tom"]
def make_users
  @users.each do |user|
    new_user = User.create(
      :username => user,
      :email => "#{user}@#{user}.com",
      :password => "password",
      :password_confirmation => "password"
      )
    @test.users << new_user
  end
end
# Sample Draft of World Championships
# @competitors = ["Shahar Shenhar", "Reid Duke", "Ben Stark", "Josh Utter-Leyton", "Craig Wescoe", "Yuya Watanabe", "Brian Kibler", "Shuhei Nakamura", "Dmitriy Butakov", "David Ochoa", "Stanislav Cifka", "Tom Martell", "Willy Edel", "Eric Froehlich", "Lee Shi Tian", "Martin Juza"]
# def draft_players
#   @competitors.each_with_index do |competitor, index|
#     if index < @users.length
#       draft_pick = Player.find_by_full_name(competitor)
#       user = @test.users.where("username = ? ", @users[index]).first
#       if draft_pick != nil
#         user.players << draft_pick
#       end
#     else
#       draft_pick = Player.find_by_full_name(competitor)
#       user = @test.users.where("username = ? ", @users[index - @users.length]).first
#       if draft_pick != nil
#         user.players << draft_pick
#       end
#     end
#   end
# end


# Running the functions defined above
make_players('http://www.wizards.com/magic/tcg/events.aspx?x=protour/standings/proplayersclub1213')

make_users

# draft_players