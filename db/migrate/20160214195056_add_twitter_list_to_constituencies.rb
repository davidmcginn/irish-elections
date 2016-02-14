class AddTwitterListToConstituencies < ActiveRecord::Migration
  def change
    add_column :constituencies, :twitter_list, :string
  end
end
