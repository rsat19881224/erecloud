class ManagementItemsController < BaseController
  permit_attributes :code, :name
end
