class DropSubAccountsTitles < ActiveRecord::Migration
  def change
  	drop_table :sub_accounts_titles
  end
end
