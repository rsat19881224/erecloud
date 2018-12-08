# -*- coding: utf-8 -*-
class CreateSubAccountsTitles < ActiveRecord::Migration
  def change
    create_table :sub_accounts_titles do |t|
      t.integer :company_id           #企業ID
      t.integer :accounts_title_id    #勘定科目ID
      t.integer :tax_division_id      #税区分ID
      t.integer :tax_rate_id          #税率ID
      t.integer :business_division_id #事業区分ID
      t.string  :code                 #補助科目コード
      t.string  :name                 #補助科目名
      t.string  :kana                 #補助科目かな
      t.string  :tax_display_type     #消費税表示方法
      t.string  :round_type           #端数処理方法

      t.timestamps
      t.datetime :deleted_at
    end

    add_index :sub_accounts_titles, :code, unique: true
  end
end
