class AddResultsUrlToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :results_url, :string
  end
end
