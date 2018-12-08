# -*- coding: utf-8 -*-
class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string  :code, null: false, default: "" #メニューコード
      t.string  :name, null: false, default: "" #メニュー名
      t.string  :product_category #製品種別
      t.string  :manager_division #管理者区分
      t.boolean :approval_setting_used, null: false, default: false #承認設定使用可否
      t.string  :extend_type      #拡張タイプ
      
      t.timestamps
      t.datetime :deleted_at
    end
    add_index :menus, :code, unique: true
  end
end
