class CreateSubAccounts < ActiveRecord::Migration
  def change
    create_table :sub_accounts do |t|
      t.integer :account_id       #勘定科目ID
      t.string  :code             #補助科目コード
      t.string  :name             #補助科目名
      t.string  :kana             #補助科目カナ
      t.integer :tax_division_id  #税区分
      t.integer :tax_rate_id      #消費税率ID
      t.integer :tax_display      #消費税表示方法
      t.integer :round            #端数処理
      t.integer :business_division_id #事業区分ID
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
