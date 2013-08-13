class CreatePlayerStandings < ActiveRecord::Migration
  def change
    create_table :player_standings do |t|
      t.integer :player_id
      t.integer :tournament_id
      t.integer :ranking
      t.integer :pro_points_earned

      t.timestamps
    end
  end
end
