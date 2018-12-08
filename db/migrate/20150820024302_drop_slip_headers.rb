class DropSlipHeaders < ActiveRecord::Migration
  def change
  	drop_table :slip_headers
  	create_table :slip_headers do |t|
      t.integer :bill_id                    #データID
      t.integer :bill_state_history_id      #履歴データID
      t.string  :slip_number                #伝票番号
      t.string  :slip_division_code	        #伝票区分コード
      t.string  :operating_division1_code   #拡張伝票区分1コード
      t.string  :operating_division2_code   #拡張伝票区分2コード
      t.string  :operating_division3_code   #拡張伝票区分3コード
      t.string  :operating_division4_code   #拡張伝票区分4コード
      t.string  :operating_division5_code   #拡張伝票区分5コード
      t.integer :user_id	                #作成ユーザーID
      t.integer :renew_user_id	            #更新ユーザーID
      t.string  :approved	                #承認フラグ
      t.boolean :exported	                #データ出力フラグ
      t.datetime :journalizing_slip_date #仕訳伝票日付
      t.integer :details_linage #明細行数
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
