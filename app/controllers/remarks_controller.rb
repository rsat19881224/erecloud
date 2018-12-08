class RemarksController < BaseController
  permit_attributes :code, :content
end
