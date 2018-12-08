# -*- coding: utf-8 -*-
class ChangeColumnToDefaultPayableSite < ActiveRecord::Migration
  def change
    # 企業IDのNOT NULL制約の追加
    change_column :default_payable_sites, :company_id, :integer, null: false
    # 約定債権債務区分のカラム名変更
    rename_column :default_payable_sites, :category           , :contract_credit_category
    # 債権債務区分の削除
    remove_column :default_payable_sites, :obligation_type    
  end
end
