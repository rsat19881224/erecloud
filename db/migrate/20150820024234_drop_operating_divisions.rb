class DropOperatingDivisions < ActiveRecord::Migration
  def change
  	drop_table :operating_divisions
  	create_table :operating_divisions do |t|
      t.integer :company_id   #企業ID
      t.string  :name         #名称
      t.string  :abbreviation #略称
      t.boolean :used         #使用有無
      t.integer :input_division #入力区分
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :operating_divisions, :name, unique: true
  end
end
