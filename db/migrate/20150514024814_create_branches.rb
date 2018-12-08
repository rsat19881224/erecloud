# -*- coding: utf-8 -*-
class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.integer :bank_id, null: false #銀行コード
      t.string  :code, null: false    #支店コード
      t.string  :name, null: false    #支店名
      t.string  :kana    #支店名カナ

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
