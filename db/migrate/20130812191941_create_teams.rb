class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :user_id
      t.integer :player_id
      t.boolean :is_active, :default => false

      t.timestamps
    end
  end
end
