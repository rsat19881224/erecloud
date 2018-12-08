class CreateSummaryDetailsSettings < ActiveRecord::Migration
  def change
    create_table :summary_details_settings do |t|
      t.integer :company_id #契約企業ID
      t.integer :rbill_summary_making #受取手形摘要反映
      t.integer :pbill_summary_making #支払手形摘要反映
      t.integer :ebill_receivable_summary_making #電子記録債権摘要反映
      t.integer :ebill_summary_making #電子記録債務摘要反映
      t.integer :factoring_credit_summary_making #ファクタリング債権摘要反映
      t.integer :factoring_debt_summary_making #ファクタリング債務摘要反映
      t.integer :date_receipt_summary_making #期日現金払_入金摘要反映
      t.integer :date_payment_summary_making #期日現金払_支払摘要反映
      t.integer :added_to_due_date  #決済時期日反映有無
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
