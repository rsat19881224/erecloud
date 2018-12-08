class Admin::ManagementDivisionsController < Admin::BaseController
  permit_attributes  :code, :name
end
