class Admin::SessionsController < Devise::SessionsController
  layout "admin/layouts/login"

  def after_sign_in_path_for(resource)
    admin_root_path
  end
  def after_sign_out_path_for(resource_name)
    new_admin_administrator_session_path
  end
end
