class DropOperatingItems < ActiveRecord::Migration
  def change
  	drop_table :operating_items
  	create_table :operating_items do |t|
      t.integer :company_id
      t.integer :operating_division_id
      t.string  :name
      t.string  :abbreviation
      t.string  :kana
      t.string  :code
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
