# -*- coding: utf-8 -*-
class CreateApprovers < ActiveRecord::Migration
  def change
    create_table :approvers do |t|
      t.integer :company_id     #企業ID
      t.integer :menu_id        #メニューID
      t.integer :user_id        #ユーザーID
      t.string  :approver_type  #承認者タイプ
      t.boolean :mail_delivered #メール配信有無

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
