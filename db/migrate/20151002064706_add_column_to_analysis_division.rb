class AddColumnToAnalysisDivision < ActiveRecord::Migration
  def change
  	add_column :analysis_divisions, :division_no, :string
  end
end
