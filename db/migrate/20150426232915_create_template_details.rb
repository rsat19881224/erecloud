class CreateTemplateDetails < ActiveRecord::Migration
  def change
    create_table :template_details do |t|
      t.integer :template_header_id	    #仕訳パターンヘッダーID
      t.integer :line_number	        #明細行番号
      t.string :balanced	            #貸借区分
      t.integer :department_id	        #部門ID
      t.integer :account_id	            #勘定科目ID
      t.integer :sub_account_id     	#補助科目ID
      t.integer :analysis_account1_id	#拡張補助1ID
      t.integer :analysis_account2_id	#拡張補助2ID
      t.integer :analysis_account3_id	#拡張補助3ID
      t.integer :analysis_account4_id	#拡張補助4ID
      t.integer :analysis_account5_id	#拡張補助5ID
      t.integer :analysis_account6_id	#拡張補助6ID
      t.integer :analysis_account7_id	#拡張補助7ID
      t.integer :analysis_account8_id	#拡張補助8ID
      t.integer :analysis_account9_id	#拡張補助9ID
      t.integer :analysis_account10_id	#拡張補助10ID
      t.string :abridgment	            #摘要

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
