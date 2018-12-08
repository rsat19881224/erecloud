# -*- coding: utf-8 -*-
class UsersController < BaseController
  permit_attributes  :code, :name, :password, :encrypted_password, :email, :contact_mail, :type, 
                     :password_unlimited, :next_login_time_password_changed, :locked, :locked_time
  
  helper_method :number_of_license, :restricted_create?, :create_quantity

  before_action :load_objects, only: [:index]
  before_action :assign_attributes, only: [:create, :update]

  def ordering(search)
    model.of_ours(@my_company)
  end

  private
  def assign_attributes
    unless @user.persisted? and @user.user_type.user_admin?nex
      @user.user_type = User.user_type.user_general
    end
    @user.company = @my_company
  end

  def number_of_create_limit(company)
    License.where(company_id: company.id).inject(0) do |acm, l|
      acm + l.number_of_license
    end
  end
  
  def restricted_create?(company)
    User.where(company_id: company.id).count + 1 > number_of_create_limit(company) ? true : false
  end
  
  def create_quantity(company)
    number_of_create_limit(company) - User.where(company_id: company.id).count
  end
end
