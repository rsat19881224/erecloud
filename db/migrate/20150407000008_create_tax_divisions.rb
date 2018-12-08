class CreateTaxDivisions < ActiveRecord::Migration
  def change
    create_table :tax_divisions do |t|
      t.string :code            #コード
      t.string :name            #名称
      t.string :indication_name #表示名称
      t.string :taxed           #課税有無

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
