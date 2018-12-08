class Admin::TaxDivisionsController < Admin::BaseController
  permit_attributes :code, :name, :indication_name, :taxed
end
