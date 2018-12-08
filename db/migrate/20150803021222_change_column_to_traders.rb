# -*- coding: utf-8 -*-
class ChangeColumnToTraders < ActiveRecord::Migration
  def change
    # 取引先コード、企業IDへのNOT NULL制約の追加
    change_column :traders, :company_id, :integer, null: false

    # 略称、郵便番号、担当者部署、担当者名のカラム名の変更
    rename_column :traders, :abbreviation   , :short_name
    rename_column :traders, :postal         , :postal_code
    rename_column :traders, :affiliated_post, :person_in_charge_official_title
    rename_column :traders, :charge_name    , :person_in_charge_name

    # 法人名称、取引先仕訳作成有無の追加
    add_column :traders, :corporation_name    , :string
    add_column :traders, :is_make_journalizing, :boolean, default: false

    # 支払企業IDの削除
    remove_column :traders, :payable_company_code

    # 契約企業IDと取引先コードをインデックスに追加
    add_index :traders, [:company_id, :code], unique: true

    # 法人番号をインデックスから除外
    remove_index :traders, :corporation_number
  end
end
