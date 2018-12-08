class Admin::CompaniesController < Admin::BaseController
  permit_attributes  :management_division_id, :number, :affiliated, :group_number, :demanded, :name, :postal_code, :prefecture, :address, :tel, :fax, :affiliated_post, :charge_name, :email
end


