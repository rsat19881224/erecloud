class CreateStampTaxes < ActiveRecord::Migration
  def change
    create_table :stamp_taxes do |t|
      t.string :tax_type   #種類
      t.integer :tax       #税額
      t.integer :above_Par #開始額面（金額）
      t.integer :below_Par #終了額面（金額）
      t.date :enforced_on  #施行日

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
