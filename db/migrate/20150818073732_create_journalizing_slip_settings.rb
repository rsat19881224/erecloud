class CreateJournalizingSlipSettings < ActiveRecord::Migration
  def change
    create_table :journalizing_slip_settings do |t|
      t.integer :company_id                           #契約企業ID
      t.string  :company_cord_for_accounts            #会社コード
      t.string  :slip_creator_code                    #起票者コード
      t.string  :approver_code                        #承認者コード
      t.integer :is_use_valuation_department          #部門使用有無
      t.integer :is_use_valuation_trader              #取引先使用有無
      t.integer :abridgment_method                    #摘要表示単位
      t.integer :number_of_output_abridgment          #出力摘要文字数
      t.integer :journalizing_processing_method_ebill #仕訳処理方法(電子記録債権)
      t.integer :journalizing_processing_method_rbill #仕訳処理方法(受取手形)
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
