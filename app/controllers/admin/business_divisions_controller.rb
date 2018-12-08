class Admin::BusinessDivisionsController < Admin::BaseController
  permit_attributes  :code, :name
end
