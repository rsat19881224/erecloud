class DropAnalysisItems < ActiveRecord::Migration
  def change
  	drop_table :analysis_items
    create_table :analysis_items do |t|
      t.integer :company_id           #企業ID
      t.integer :analysis_division_id #拡張伝票区分ID
      t.string  :name                 #名称
      t.string  :abbreviation         #略称
      t.string  :kana                 #カナ
      t.string :code #コード
      t.timestamps
      t.datetime :deleted_at
    end

    add_index :analysis_items, :name, unique: true
  end
end
