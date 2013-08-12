class Player < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :nationality, :pro_club_level
end
