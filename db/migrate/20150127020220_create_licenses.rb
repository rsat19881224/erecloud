# -*- coding: utf-8 -*-
class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.integer  :company_id,        null: false #契約企業ID
      t.integer  :product_id,        null: false #製品ID
      t.integer  :number_of_license, null: false #ライセンス数
      t.datetime :use_starting_date, null: false #使用開始日
      t.datetime :use_end_date,      null: false #使用終了日
      t.integer  :period_of_service, null: false #使用期間
      t.string   :license_type,      null: false #ライセンスタイプ

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
