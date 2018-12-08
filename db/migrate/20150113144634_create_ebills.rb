class CreateEbills < ActiveRecord::Migration
  def change
    create_table :ebills do |t|
      t.integer :company_id #契約企業ID
      t.string :type #STI用
      t.integer :company_type #企業区分
      t.integer :counterparty_company_id #相手方契約企業ID
      t.integer :data_type #債権種類
      t.integer :settlement_type #一括決済区分
      t.integer :factor_id #一括決済機関
      t.string :control_number #管理番号
      t.integer :recording_institution_id #記録機関ID
      t.string :recording_number #記録番号
      t.integer :accrual_type #発生区分
      t.boolean :transferred #譲渡有無
      t.integer :occurrence_type #発生日区分
      t.date :occurred_on #発生日
      t.date :due_become_on #支払期日
      t.integer :issue_money #金額
      t.boolean :transfer_restricted #譲渡制限有無
      t.string :ref_no #（依頼人）Ref.No
      t.string :debtor_user_number #債務者利用者番号
      t.string :creditor_user_number #債権者利用者番号
      t.integer :trader_id #債権者 取引先ID
      t.integer :creditor_type #債権者種類
      t.string :creditor_name #債権者名カナ
      t.string :creditor_bank_code #債権者銀行コード
      t.string :creditor_bank_kana #債権者銀行カナ
      t.string :creditor_branch_code #債権者本支店コード
      t.string :creditor_branch_kana #債権者本支店カナ
      t.integer :creditor_account_type #債権者口座種別
      t.string :creditor_account_number #債権者口座番号
      t.integer :debtors_company_bank_id #債務者取引銀行ID
      t.integer :debtors_department_id #債務者部門ID
      t.string :debtors_remarks #債務者備考
      t.boolean :drawing_Journal_made #振出仕訳作成フラグ
      t.string :transferor_user_number #譲渡人利用者番号
      t.string :assignor_name #譲渡人名カナ
      t.string :assignor_bank_code #譲渡人銀行コード
      t.string :assignor_bank_kana #譲渡人銀行カナ
      t.string :assignor_branch_code #譲渡人本支店コード
      t.string :assignor_branch_kana #譲渡人本支店カナ
      t.integer :assignor_account_type #譲渡人口座種別
      t.string :assignor_account_number #譲渡人口座番号
      t.string :debtor_trader_name #債務者カナ
      t.string :debtor_bank_code #債務者銀行コード
      t.string :debtor_bank_kana #債務者銀行カナ
      t.string :debtor_branch_code #債務者本支店コード
      t.string :debtor_branch_kana #債務者本支店カナ
      t.integer :debtor_account_type #債務者口座種別
      t.string :debtor_account_number #債務者口座番号
      t.integer :residual_money #残高
      t.boolean :record_settled #記録確定ステータス
      t.integer :approver_type #承認者区分
      t.boolean :approved #承認フラグ
      t.boolean :up_load_made #集信１作成フラグ
      t.boolean :payment_data_made #支払データ作成フラグ
      t.integer :payment_guidance_issued #支払通知書発行区分
      t.date :settled_on #決済支払日
      t.boolean :settlement_Journal_made #債務者決済仕訳作成フラグ
      t.integer :debt_state_division #＊債務状態区分
      t.integer :insolvency_presence #＊支払不能有無
      t.date :returned_on #債務者組戻日付
      t.integer :return_state #債務者組戻てん末名
      t.string :return_remarks #債務者組戻備考
      t.boolean :debtor_deleted #債務者企業データ削除フラグ
      t.integer :record_type #登録区分
      t.integer :created_user_id #債務者企業新規登録ユーザー
      t.integer :update_user_id #債務者企業更新ユーザー

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
