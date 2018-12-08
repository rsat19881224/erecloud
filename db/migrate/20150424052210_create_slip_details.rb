class CreateSlipDetails < ActiveRecord::Migration
  def change
    create_table :slip_details do |t|
      t.integer :slip_header_id	         #仕訳伝票ヘッダーID
      t.string :line_number	             #明細行番号
      t.string :balanced	             #貸借区分
      t.string :department_code	         #部門
      t.string :department_name	         #部門名
      t.string :account_code	         #勘定科目コード
      t.string :account_name	         #勘定科目名
      t.string :sub_account_code	     #補助科目コード
      t.string :sub_account_name	     #補助科目名
      t.string :including_tax 	         #税込金額
      t.integer :excluding_taxes 	     #税抜金額
      t.integer :consumption_tax 	     #消費税金額
      t.string :tax_division_code	     #税区分
      t.string :tax_division_name	     #税区分名称
      t.integer :tax_rate	             #消費税率
      t.string :business_division_code   #事業区分
      t.string :analysis_account1_code   #拡張補助1コード
      t.string :analysis_account2_code   #拡張補助2コード
      t.string :analysis_account3_code   #拡張補助3コード
      t.string :analysis_account4_code   #拡張補助4コード
      t.string :analysis_account5_code   #拡張補助5コード
      t.string :analysis_account6_code   #拡張補助6コード
      t.string :analysis_account7_code   #拡張補助7コード
      t.string :analysis_account8_code   #拡張補助8コード
      t.string :analysis_account9_code   #拡張補助9コード
      t.string :analysis_account10_code  #拡張補助10コード
      t.string :trader_code	             #取引先コード
      t.string :abridgment	             #摘要
      t.integer :details_linage #明細行数
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
