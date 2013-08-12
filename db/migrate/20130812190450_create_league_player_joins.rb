class CreateLeaguePlayerJoins < ActiveRecord::Migration
  def change
    create_table :league_player_joins do |t|
      t.integer :player_id
      t.integer :league_id

      t.timestamps
    end
  end
end
