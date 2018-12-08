class CreateTaxRates < ActiveRecord::Migration
  def change
    create_table :tax_rates do |t|
      t.string :code       #コード
      t.string :name       #名称
      t.string :rate       #税率
      t.date :executed_on  #施行日
      t.boolean :used      #使用有無

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
