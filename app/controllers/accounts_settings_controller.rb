class AccountsSettingsController < BaseController
  permit_attributes :endorsement_ac_used, :discount_ac_used, :abridgment_method, :remarks1_reflected, :remarks2_reflected, 
                    :remarks3_reflected, :payment_type, :notice_journal_made
  
  before_action :create_accounts_setting
  before_action :load_object
  
  def load_object
    instance_variable_set \
      "@#{model_name.underscore}",
      (@instance = model.find_by_company_id(current_user.company_id) rescue nil).tap { |instance| instance.try(:assign_attributes, permitted_parameters) }
  end

  def redirect_path
    accounts_setting_path
  end
  
  def create_accounts_setting
    unless model.find_by_company_id(@my_company.id)
      AccountsSetting.create(
        company_id: @my_company.id,
        endorsement_ac_used: false, 
        discount_ac_used: false, 
        abridgment_method: "line", 
        remarks1_reflected: false, 
        remarks2_reflected: false, 
        remarks3_reflected: false, 
        payment_type: "no_payment", 
        notice_journal_made: false
      )
    end
  end
end
