class Admin::StampTaxesController < Admin::BaseController
  permit_attributes  :tax_type, :tax, :above_Par, :below_Par, :enforced_on
end
