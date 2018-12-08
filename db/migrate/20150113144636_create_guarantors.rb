class CreateGuarantors < ActiveRecord::Migration
  def change
    create_table :guarantors do |t|
      t.integer :ebill_id #電子記録債権ID
      t.string :user_number #保証人利用者番号
      t.string :guarantor_name #保証人名称
      t.string :guarantor_name_kana #保証人名カナ
      t.string :bank_code #保証人銀行コード
      t.string :bank_kana #保証人銀行名カナ
      t.string :branch_code #保証人本支店コード
      t.string :branch_kana #保証人本支店名カナ
      t.integer :account_type #保証人口座種別
      t.string :account_number #口座番号
      t.date :guaranty_recorded_on #保証記録年月日

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
