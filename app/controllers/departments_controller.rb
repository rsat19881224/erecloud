class DepartmentsController < BaseController
  permit_attributes :company_id, :code, :name, :name_kana, :abbreviation
end
