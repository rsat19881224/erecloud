class CreateOutputOrders < ActiveRecord::Migration
  def change
    create_table :output_orders do |t|
      t.integer :output_form_id #出力形式ID
      t.integer :journalizing_output_item_id #出力項目
      t.integer :item_attribution #項目種別
      t.integer :addition_rule #付加ルール
      t.integer :addition_state #付加てん末
      t.string :fixed_value_data #固定値データ
      t.string :output_number #出力No
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
