class DropAccountsTitles < ActiveRecord::Migration
  def change
  	drop_table :accounts_titles
  end
end
