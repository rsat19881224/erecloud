class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :company_id #契約企業ID
      t.string :code #勘定科目コード
      t.string :name #勘定科目名
      t.string :kana #勘定科目カナ
      t.integer :tax_division_id #税区分
      t.integer :tax_rate_id #消費税率ID
      t.integer :tax_display #消費税表示方法
      t.integer :round #端数処理
      t.integer :business_division_id #事業区分ID
      t.integer :fund_division #諸口科目区分
      t.integer :tax_subject_division #消費税科目区分
      t.integer :trader_shared #取引先・補助適用区分
      t.integer :department_input #部門入力区分
      t.integer :trader_input_division #取引先入力区分
      t.boolean :analysis1_input #入力有無　拡張補助1
      t.boolean :analysis2_input #入力有無　拡張補助2
      t.boolean :analysis3_input #入力有無　拡張補助3
      t.boolean :analysis4_input #入力有無　拡張補助4
      t.boolean :analysis5_input #入力有無　拡張補助5
      t.boolean :analysis6_input #入力有無　拡張補助6
      t.boolean :analysis7_input #入力有無　拡張補助7
      t.boolean :analysis8_input #入力有無　拡張補助8
      t.boolean :analysis9_input #入力有無　拡張補助9
      t.boolean :analysis10_input #入力有無　拡張補助10
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
