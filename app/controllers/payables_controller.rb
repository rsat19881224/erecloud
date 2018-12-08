class PayablesController < BaseController
  permit_attributes  :control_number

  def ordering(search)
    model.of_ours(@my_company)
  end
end
