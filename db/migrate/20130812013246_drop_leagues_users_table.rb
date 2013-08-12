class DropLeaguesUsersTable < ActiveRecord::Migration
  def change
    drop_table :leagues_users
  end
end
