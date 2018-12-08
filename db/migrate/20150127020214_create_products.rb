# -*- coding: utf-8 -*-
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :code, null: false, default: ""                       #製品コード
      t.string  :name, null: false, default: ""                       #製品名
      t.boolean :bill_credit_used, null: false, default: false        #受取手形使用有無
      t.boolean :bill_debit_used, null: false, default: false         #支払手形使用有無
      t.boolean :ebill_credit_used, null: false, default: false       #電子記録債権使用有無
      t.boolean :ebill_debit_used, null: false, default: false        #電子記録債務使用有無
      t.boolean :factoring_credit_used, null: false, default: false   #ファクタリング債権使用有無
      t.boolean :factoring_debit_used, null: false, default: false    #ファクタリング債務使用有無
      t.boolean :account_receivable_used, null: false, default: false #売掛金使用有無
      t.boolean :account_payable_used, null: false, default: false    #買掛金使用有無
      t.boolean :print_option_used, null: false, default: false       #印刷オプション使用有無
      t.boolean :extended, null: false, default: false                #拡張有無
      
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :products, :code, unique: true
  end
end
