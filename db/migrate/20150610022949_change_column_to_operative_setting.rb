# -*- coding: utf-8 -*-
class ChangeColumnToOperativeSetting < ActiveRecord::Migration
  def change
    # 企業IDへのNOT NULL制約の追加
    change_column :operative_settings, :company_id   , :integer, null: false
    # 会社名1へのNOT NULL制約の追加
    change_column :operative_settings, :company_name1, :string , null: false

    # 代表者名、代表者役職、担当者名、担当者役職のカラム名変更
    rename_column :operative_settings, :epresentative_name  , :representative_name
    rename_column :operative_settings, :representative_title, :representative_official_title
    rename_column :operative_settings, :charge_name         , :person_in_charge_name
    rename_column :operative_settings, :affiliated_post     , :person_in_charge_official_title

    # 期日振替有無、電子記録債権決済有無、部門権限使用有無の削除
    remove_column :operative_settings, :date_transferred
    remove_column :operative_settings, :ebill_state_changed
    remove_column :operative_settings, :department_authority_used

    # 日付振替有無の追加、デフォルトで日付振替を行うを指定
    add_column :operative_settings, :is_transfer_fixed_date           , :boolean, null: false, default: true
    # 仕訳処理（受取手形）の追加、デフォルトで評価勘定を使用するを指定
    add_column :operative_settings, :is_use_valuation_account_of_bill , :boolean, null: false, default: true
    # 仕訳処理（電子記録債権）の追加、デフォルトで評価勘定を使用しないを指定
    add_column :operative_settings, :is_use_valuation_account_of_ebill, :boolean, null: false, default: true
    # 部門権限使用有無の追加、デフォルトで使用しないを指定
    add_column :operative_settings, :is_use_section_authority         , :boolean, null: false, default: false
  end
end
