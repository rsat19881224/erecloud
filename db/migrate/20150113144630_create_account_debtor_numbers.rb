class CreateAccountDebtorNumbers < ActiveRecord::Migration
  def change
    create_table :account_debtor_numbers do |t|
      t.integer :company_id #契約企業ID
      t.integer :type #区分
      t.integer :trader_id #取引先ID
      t.integer :recording_institution_id #電子債権記録機関ID
      t.string :user_number #利用者番号

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
