class AddInProcessToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :in_process, :boolean, :default => false
  end
end
