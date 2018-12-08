class AddColumnToOperatingDivision < ActiveRecord::Migration
  def change
  	add_column :operating_divisions, :division_no, :string
  end
end
