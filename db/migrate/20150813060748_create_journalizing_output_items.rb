class CreateJournalizingOutputItems < ActiveRecord::Migration
  def change
    create_table :journalizing_output_items do |t|
      t.integer :code #コード
      t.string :name #名称
      t.string :name_for_indication #表示用名称
      t.integer :item_division #項目区分
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
