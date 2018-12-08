class Admin::BankHolidaysController < Admin::BaseController
  permit_attributes :holiday

  def delivery_action_gon
    gon.date_format = "YYYY/MM/DD"
    super
  end
end
