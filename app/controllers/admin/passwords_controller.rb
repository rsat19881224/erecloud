class Admin::PasswordsController < Devise::PasswordsController
  layout "admin/layouts/login"

  def after_sign_in_path_for(resource)
    admin_root_path
  end
end
