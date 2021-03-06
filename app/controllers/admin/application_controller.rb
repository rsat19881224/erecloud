class Admin::ApplicationController < BaseController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  skip_before_filter :authenticate_user!
  before_filter :authenticate_admin_administrator!

  layout "admin/layouts/application"
end
