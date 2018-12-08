# -*- coding: utf-8 -*-
class CreateOperativeSettings < ActiveRecord::Migration
  def change
    create_table :operative_settings do |t|
      t.integer :company_id, null: false, default: 0 #契約企業ID
      t.string :company_name1 #会社名１
      t.string :company_name2 #会社名２
      t.string :postal_code #郵便番号
      t.string :address1 #住所１
      t.string :address2 #住所２
      t.string :representative_title #代表者役職名
      t.string :epresentative_name #代表者名
      t.string :company_number #法人番号
      t.string :affiliated_post #担当者部署
      t.string :charge_name #担当者名
      t.string :date_display_format #暦表示方法
      t.boolean :date_transferred #期日振替有無
      t.boolean :ebill_state_changed #電子記録差権決済有無
      t.boolean :department_authority_used #部門権限使用有無

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
