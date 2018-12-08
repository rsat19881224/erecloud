class CreateAccountsSettings < ActiveRecord::Migration
  def change
    create_table :accounts_settings do |t|
      t.integer :company_id   #企業ID
      t.boolean :endorsement_ac_used, default: false   #裏書評価勘定使用有無 
      t.boolean :discount_ac_used, default: false      #割引評価勘定使用有無
      t.string :abridgment_method, default: "line"     #摘要表示単位
      t.boolean :remarks1_reflected, default: false    #備考1の摘要反映有無
      t.boolean :remarks2_reflected, default: false    #備考2の摘要反映有無
      t.boolean :remarks3_reflected, default: false    #備考3の摘要反映有無
      t.string :payment_type, default: "no_payment"    #入金・支払区分
      t.boolean :notice_journal_made, default: false   #通知日仕訳作成有無

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
