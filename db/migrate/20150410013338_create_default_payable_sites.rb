# -*- coding: utf-8 -*-
class CreateDefaultPayableSites < ActiveRecord::Migration
  def change
    create_table :default_payable_sites do |t|
      t.integer :company_id              #企業ID
      t.string  :obligation_type         #債権債務区分
      t.string  :designated_division     #日付指定区分
      t.string  :category                #項目区分
      t.string  :site_designation_method #サイト指定方法
      t.integer :month                   #nヶ月
      t.integer :day                     #m日後
      t.integer :after_day               #s日後
      t.string  :holiday_transfer_method #休日振替方法

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
