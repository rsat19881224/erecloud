class Admin::UsersController < Admin::BaseController
  permit_attributes  :code, :name, :password, :email, :contact_mail, :user_type, 
                     :password_unlimited, :next_login_time_password_changed, :locked, :locked_time
  
  before_action :assign_attributes, only: [:create, :update]
  skip_before_action :set_company
  protected
  def load_object
    instance_variable_set \
      "@user",
      (@instance = @company.admin_user rescue nil).tap { |instance| instance.try(:assign_attributes, permitted_parameters) }
  end

  def redirect_path
    polymorphic_path([:admin, Company])
  end

  private
  def load_company
    @company = Company.find(params[:company_id])
  end

  def assign_attributes
    unless @user.persisted?
      @user.user_type = User.user_type.user_admin
    end
    @user.company = @company
  end
end
