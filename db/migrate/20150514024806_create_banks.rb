# -*- coding: utf-8 -*-
class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :code, null: false #銀行コード
      t.string :name, null: false #銀行名
      t.string :kana #銀行名カナ

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
