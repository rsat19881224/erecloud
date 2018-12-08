class CreateEbillReceivableStates < ActiveRecord::Migration
  def change
    create_table :ebill_receivable_states do |t|
            
      t.integer   :ebill_id     #電子記録債権ID
      t.integer   :recording_institution_id     #記録機関ID
      t.string    :recording_number , limit:  20  #記録番号
      t.integer   :state_code_id  , limit:  3 #てん末コードID
      t.integer   :acquisition_division , limit:  3 #取得区分
      t.integer   :trader_id      #取引先
      t.string    :trader_name1     #取引先名称１
      t.string    :trader_name2     #取引先名称２
      t.string    :trader_kana  , limit:  40  #取引先カナ
      t.string    :trader_bank_code , limit:  4 #取引先銀行コード
      t.string    :trader_bank_kana , limit:  15  #取引先銀行カナ
      t.string    :trader_branch_code , limit:  3 #取引先本支店コード
      t.string    :trader_branch_kana , limit:  15  #取引先本支店カナ
      t.integer   :trader_account_type  , limit:  3 #取引先口座種別
      t.string    :trader_account_number  , limit:  7 #取引先口座番号
      t.string    :trader_user_number , limit:  9 #取引先利用者番号
      t.string    :debtor_user_number , limit:  9 #債務者利用者番号
      t.string    :debtor_name  , limit:  50  #債務者名称
      t.string    :debtor_kana  , limit:  40  #債務者カナ
      t.string    :debtor_bank_code , limit:  4 #債務者銀行コード
      t.string    :debtor_bank_kana , limit:  15  #債務者銀行カナ
      t.string    :debtor_branch_code , limit:  3 #債務者本支店コード
      t.string    :debtor_branch_kana , limit:  15  #債務者本支店カナ
      t.integer   :debtor_account_type  , limit:  3 #債務者口座種別
      t.string    :debtor_account_number  , limit:  7 #債務者口座番号
      t.date      :transferred_on     #異動日付
      t.date      :occurred_on      #発生日
      t.decimal   :issue_money  , limit:  11  #原債権金額
      t.decimal   :amount_money , limit:  11  #異動金額
      t.decimal   :residual_money , limit:  11  #債権残高
      t.decimal   :number_of_times  , limit:  4 #分割回数
      t.date      :discount_requested_on      #割引依頼日
      t.date      :matured_on     #支払期日
      t.date      :settled_on     #債権者決済入金日
      t.integer   :company_bank_id      #債権者取引銀行ID
      t.integer   :department_id      #債権者部門ID
      t.integer   :operating_item_id      #債権者拡張伝票マスターID
      t.integer   :bmanagement_item_id      #債権者管理項目ID
      t.integer   :transferee_guaranteed  , limit:  3 #譲受時保証有無
      t.integer   :transfer_restricted  , limit:  3 #譲渡制限有無
      t.string    :division_recording_number  , limit:  20  #分割記録番号
      t.integer   :transferee_trader_id     #譲渡先
      t.string    :transferee_name1     #譲渡先名称１
      t.string    :transferee_name2     #譲渡先名称２
      t.string    :transferee_kana  , limit:  40  #譲渡先名カナ
      t.string    :transferee_bank_code , limit:  4 #譲渡先銀行コード
      t.string    :transferee_bank_kana , limit:  15  #譲渡先銀行名カナ
      t.string    :transferee_branch_code , limit:  3 #譲渡先本支店コード
      t.string    :transferee_branch_kana , limit:  15  #譲渡先本支店名カナ
      t.integer   :transferee_account_type  , limit:  3 #譲渡先口座種別
      t.string    :transferee_account_number , limit:  7 #譲渡先口座番号
      t.string    :transferee_user_number , limit:  9 #譲渡先利用者番号
      t.integer   :guaranteed , limit:  3 #譲渡時保証有無
      t.decimal   :discount_charge  , limit:  11  #割引手数料
      t.decimal   :bank_transfer_fee  , limit:  11  #振込手数料
      t.integer   :own_state_id     #自社てん末ID
      t.integer   :Journal_made , limit:  3 #てん末仕訳作成フラグ
      t.integer   :discount_guidance_issued , limit:  3 #割引申込書発行区分
      t.integer   :payment_guidance_issued  , limit:  3 #譲渡時支払通知発行区分
      t.integer   :return_state , limit:  3 #組戻てん末名
      t.string    :ref_no , limit:  40  #依頼人Ref.No.
      t.string    :remarks1 , limit:  50  #債権者備考1
      t.string    :remarks2 , limit:  50  #債権者備考2
      t.string    :remarks3 , limit:  50  #債権者備考3
      t.integer   :creditor_deleted , limit:  3 #債権者企業削除フラグ
      t.decimal   :recordable_number_of_times  , limit:  4   #分割記録可能回数
      t.integer   :approver_type  , limit:  3 #承認者区分
      t.integer   :approved , limit:  3 #承認フラグ
      t.integer   :output , limit:  3 #譲渡データ出力フラグ
    end
  end
end
