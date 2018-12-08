class CreateOperatingDivisionSettings < ActiveRecord::Migration
  def change
    create_table :operating_division_settings do |t|
      t.integer :company_id
      t.integer :operating_division_id
      t.string  :input_type

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
