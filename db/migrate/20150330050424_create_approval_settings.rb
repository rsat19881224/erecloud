# -*- coding: utf-8 -*-
class CreateApprovalSettings < ActiveRecord::Migration
  def change
    create_table :approval_settings do |t|
      t.integer :company_id                #会社ID 
      t.integer :menu_id                   #メニューID
      t.string  :approval_type             #承認タイプ
      t.boolean :one_phase_approval_skiped #1段階承認

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
