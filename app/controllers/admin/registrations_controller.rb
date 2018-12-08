class Admin::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :exception

  before_filter :authenticate_admin_administrator!

  layout "admin/layouts/application"

  def after_update_path_for(resource)
    admin_root_path
  end
end
