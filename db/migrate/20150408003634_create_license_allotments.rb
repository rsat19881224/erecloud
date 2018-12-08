# -*- coding: utf-8 -*-
class CreateLicenseAllotments < ActiveRecord::Migration
  def change
    create_table :license_allotments do |t|
      t.integer :company_id #企業ID
      t.integer :user_id    #ユーザーID
      t.integer :license_id #ライセンスID
      
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
