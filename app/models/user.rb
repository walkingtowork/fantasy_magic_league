class User < ActiveRecord::Base
  has_many :seasons
  has_many :leagues, :through => :seasons

  has_many :teams
  has_many :players, :through => :teams

  authenticates_with_sorcery!
  attr_accessible :username, :email, :password, :password_confirmation, :buy_points, :victory_points

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
end