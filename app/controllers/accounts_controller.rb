class AccountsController < BaseController
	  permit_attributes :code, :name, :kana, :tax_division_id, :tax_rate_id, :tax_display, 
	  :round, :business_division_id, :fund_division, :tax_subject_division, :trader_shared, 
	  :department_input, :trader_input_division, :analysis1_input, :analysis2_input, 
	  :analysis3_input, :analysis4_input, :analysis5_input, :analysis6_input, :analysis7_input, 
	  :analysis8_input, :analysis9_input, :analysis10_input

	def new
    @account = Account.new(:tax_display => 2, :round => 1, :fund_division => 1, :tax_subject_division => 1, 
    	:trader_shared => 1, :department_input => 1, :trader_input_division => 1, 
    	:analysis1_input => 'analysis1_input_no_input', :analysis2_input => 'analysis2_input_no_input', 
    	:analysis3_input => 'analysis3_input_no_input', :analysis4_input => 'analysis4_input_no_input', 
    	:analysis5_input => 'analysis5_input_no_input', :analysis6_input => 'analysis6_input_no_input', 
    	:analysis7_input => 'analysis7_input_no_input', :analysis8_input => 'analysis8_input_no_input', 
    	:analysis9_input => 'analysis9_input_no_input', :analysis10_input => 'analysis10_input_no_input')
  end
end
