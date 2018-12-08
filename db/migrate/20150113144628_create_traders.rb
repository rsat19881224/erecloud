# -*- coding: utf-8 -*-
class CreateTraders < ActiveRecord::Migration
  def change
    create_table :traders do |t|
      t.integer :company_id           #契約企業ID
      t.string  :code                 #取引先コード
      t.string  :corporation_number   #法人番号
      t.string  :name1                #取引先名１
      t.string  :name2                #取引先名２
      t.string  :kana                 #取引先名カナ
      t.string  :abbreviation         #取引先名略称
      t.string  :postal               #郵便番号
      t.string  :address1             #住所１
      t.string  :address2             #住所２
      t.string  :affiliated_post      #担当者部署
      t.string  :charge_name          #担当者名
      t.string  :tel                  #電話番号
      t.string  :fax                  #ファックス番号
      t.string  :email                #メールアドレス
      t.string  :reference_type       #参照区分
      t.string  :customer_code        #得意先コード
      t.string  :vendor_code          #支払先コード
      t.string  :payable_company_code #支払企業コード

      t.timestamps
      t.datetime :deleted_at
    end
    add_index :traders, :code, unique: true
    add_index :traders, :corporation_number, unique: true
  end
end

