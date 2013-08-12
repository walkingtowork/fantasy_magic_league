class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :turn_order
      t.integer :user_id
      t.integer :league_id
      t.boolean :in_process, :default => false

      t.timestamps
    end
  end
end
