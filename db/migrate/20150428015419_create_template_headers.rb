class CreateTemplateHeaders < ActiveRecord::Migration
  def change
    create_table :template_headers do |t|
      t.integer :company_id              #契約企業ID
      t.string :setting_type             #設定区分
      t.string :item                     #設定種別
      t.string :division                 #債権債務種別
      t.integer :management_item_id      #管理項目ID
      t.integer :company_bank_id         #自社取引銀行ID
      t.integer :trader_id               #取引先ID
      t.integer :state_code_id           #てん末コードID
      t.integer :own_state_id            #自社てん末ID
      t.integer :slip_division_id        #伝票区分
      t.integer :operating_division1_id  #拡張伝票区分1
      t.integer :operating_division2_id	 #拡張伝票区分2
      t.integer :operating_division3_id	 #拡張伝票区分3
      t.integer :operating_division4_id	 #拡張伝票区分4
      t.integer :operating_division5_id	 #拡張伝票区分5

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
