# -*- coding: utf-8 -*-
class CreateTraderBankAccounts < ActiveRecord::Migration
  def change
    create_table :trader_bank_accounts do |t|
      t.integer :trader_id           #取引先ID
      t.string  :bank_code           #銀行コード
      t.string  :bank_name           #銀行名
      t.string  :bank_kana           #銀行名カナ
      t.string  :branch_code         #本支店コード
      t.string  :branch_name         #本支店名
      t.string  :branch_kana         #本支店カナ
      t.string  :account_type        #預金種目
      t.string  :account_number      #口座番号
      t.string  :account_name        #口座名義機
      t.string  :account_name_kana   #口座名義カナ
      t.string  :client_code1        #顧客コード１
      t.string  :client_code2        #顧客コード２
      t.string  :ebill_user_number   #でんさい利用者番号
      t.string  :jemco_client_number #電手お客様番号
      t.string  :jemco_creditor_code #電手仕入先コード

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
