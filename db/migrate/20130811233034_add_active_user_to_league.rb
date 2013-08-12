class AddActiveUserToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :active_user_id, :integer
    add_column :leagues, :drafting, :boolean, :default => false
  end
end
