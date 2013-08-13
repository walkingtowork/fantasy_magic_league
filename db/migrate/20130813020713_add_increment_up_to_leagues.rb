class AddIncrementUpToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :increment_up, :boolean, :default => true
  end
end
