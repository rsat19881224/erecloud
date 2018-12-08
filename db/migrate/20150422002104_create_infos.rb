class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string  :type       #STI用
      t.string  :title      #
      t.string  :content    #
      t.date :display_from  #
      t.date :display_to    #

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
