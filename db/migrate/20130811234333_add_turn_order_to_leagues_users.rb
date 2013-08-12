class AddTurnOrderToLeaguesUsers < ActiveRecord::Migration
  def change
    add_column :leagues_users, :turn_order, :integer
  end
end
