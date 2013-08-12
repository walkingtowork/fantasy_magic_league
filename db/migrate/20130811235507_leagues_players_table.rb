class LeaguesPlayersTable < ActiveRecord::Migration
  def change
    create_table :leagues_players do |t|
      t.integer :league_id
      t.integer :player_id
      t.integer :pick_order
      t.integer :user_id
    end
  end
end
