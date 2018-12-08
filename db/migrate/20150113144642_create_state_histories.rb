class CreateStateHistories < ActiveRecord::Migration
  def change
    create_table :state_histories do |t|
      t.integer :ebill_id #電子記録債権ID
      t.integer :state_type #てん末区分
      t.integer :trader_id #取引先
      t.date :transferred_on #異動日付
      t.integer :amount_money #異動金額
      t.date :settled_on #債権者決済入金日
      t.integer :company_bank_id #債権者取引銀行ID
      t.integer :department_id #債権者部門ID
      t.boolean :receipt_data_made #入金データ作成フラグ
      t.integer :division_type #分割区分
      t.string :division_recording_number #分割記録番号
      t.integer :record_settled #記録確定ステータス
      t.string :transferee_user_number #譲渡先利用者番号
      t.string :transferee_kana #譲渡先名カナ
      t.string :transferee_bank_code #譲渡先銀行コード
      t.string :transferee_bank_kana #譲渡先銀行名カナ
      t.string :transferee_branch_code #譲渡先本支店コード
      t.string :transferee_branch_kana #譲渡先本支店名カナ
      t.integer :transferee_account_type #譲渡先口座種別
      t.string :transferee＿account_number #譲渡先口座番号
      t.integer :guaranteed #譲渡時保証有無
      t.integer :discount_charge #割引手数料
      t.integer :bank_transfer_fee #振込手数料
      t.integer :own_state_id #自社てん末ID
      t.integer :Journal_made #てん末仕訳作成フラグ
      t.integer :discount_guidance_issued #割引案内書発行区分
      t.integer :return_state #組戻てん末名
      t.string :ref_no #依頼人Ref.No.
      t.string :remarks #債権者備考
      t.integer :record_type #登録区分
      t.integer :creditor_deleted #債権者企業削除フラグ
      t.integer :created_user_id #債権者企業新規登録ユーザー
      t.integer :update_user_id #債権者企業更新ユーザー

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
