class AbridgmentsController < BaseController
  permit_attributes :code, :contents
end
