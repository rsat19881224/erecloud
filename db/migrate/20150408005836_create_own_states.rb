class CreateOwnStates < ActiveRecord::Migration
  def change
    create_table :own_states do |t|
      t.integer :company_id #契約企業ID
      t.string :code        #コード
      t.string :name        #名称
      t.string :type        #相手先区分

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
