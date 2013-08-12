class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :nationality
      t.string :pro_club_level

      t.timestamps
    end
  end
end
