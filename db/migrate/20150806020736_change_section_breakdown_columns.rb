class ChangeSectionBreakdownColumns < ActiveRecord::Migration
  def change
    rename_column :section_breakdowns, :ebill_id, :bill_id
    rename_column :section_breakdowns, :type, :input_type
    rename_column :section_breakdowns, :segment_id, :management_item_id
  end
end
