class League < ActiveRecord::Base
  has_many :seasons
  has_many :users, :through => :seasons

  attr_accessible :name, :admin_id, :active_user_id
end
