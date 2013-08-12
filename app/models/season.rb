class Season < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  attr_accessible :turn_order, :user_id, :league_id, :in_process

  # def set_turn_order
  #   @league.users.shuffle.each do |user|
  #     @league.find_user_by(:user_id)

  #   end
  # end
end
