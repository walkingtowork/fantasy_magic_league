class RemoveDraftingFromLeagues < ActiveRecord::Migration
  def change
    remove_column :leagues, :drafting
  end
end
