class AddPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :buy_points, :integer, :default => 648
    add_column :users, :victory_points, :integer
  end
end
