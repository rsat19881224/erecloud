# -*- coding: utf-8 -*-
class ChangeColumnToDefaultPayableSites < ActiveRecord::Migration
  def change
    # 設定区分にNOT NULL制約の追加
    change_column :default_payable_sites, :setting_type, :integer, null: false
  end
end
