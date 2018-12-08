class Admin::MenusController < Admin::BaseController
  permit_attributes :code, :name, :product_category, :manager_division, :approval_setting_used, :extend_type

  def edit
    gon.extend_type = @menu.extend_type
    gon.approval_setting_used = @menu.approval_setting_used
    super
  end
end
