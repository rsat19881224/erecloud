class SecurityPoliciesController < BaseController
  permit_attributes :min_characters, :included_three_kinds, :included_account, :number_of_history_generations, 
                    :valid_period, :change_prohibition_period, :lockout_setting, :time_elapsed
  
  before_action :create_security_policy
  before_action :load_object
  
  def load_object
    instance_variable_set \
      "@#{model_name.underscore}",
      (@instance = model.find_by_company_id(current_user.company_id) rescue nil).tap { |instance| instance.try(:assign_attributes, permitted_parameters) }
  end

  def redirect_path
    security_policy_path
  end
  
  def create_security_policy
    unless model.find_by_company_id(@my_company.id)
      SecurityPolicy.create(
        company_id: @my_company.id,
         included_three_kinds: true,
         included_account: true
      )
    end
  end
end
