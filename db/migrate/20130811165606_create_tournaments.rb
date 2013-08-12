class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.date :date
      t.string :location
      t.string :tournament_type

      t.timestamps
    end
  end
end
