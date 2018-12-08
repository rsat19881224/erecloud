class CreateCompanyBanks < ActiveRecord::Migration
  def change
    create_table :company_banks do |t|
      t.integer :company_id #契約企業ID
      t.string :code #自社取引銀行コード
      t.string :name #名称
      t.string :bank_code #銀行コード
      t.string :bank_name #銀行名
      t.string :bank_kana #銀行名カナ
      t.string :branch_code #本支店コード
      t.string :branch_name #本支店名
      t.string :branch_kana #本支店カナ
      t.string :account_type #預金種目
      t.string :account_number #口座番号
      t.string :account_name #口座名義
      t.string :account_name_kana #口座名義カナ
      t.integer :line_discount  #割引限度額
      t.string :client_code #依頼人コード
      t.string :user_number #でんさい利用者番号
      t.string :jemco_number #電手お客様番号
      t.string :mizuho_number #電ペイ利用者番号
      t.string :smbc_number #SMBC電子債権利用者番号
      t.string :record_length, default: "120" #レコード長
      t.boolean :record_type, default: true #コード区分
      t.boolean :carriage_return, default: true #改行コード
      t.boolean :end_of_file, default: true #終端コード

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
