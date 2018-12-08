class Admin::AdministratorsController < Admin::BaseController
  permit_attributes  :name, :email, :password, :password_confirmation, :administrator_type
end
