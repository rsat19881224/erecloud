class PaymentNoticesController <  BaseController
  permit_attributes :trader_from, :trader_to, :payment_date_from, :payment_date_to, :payment_target

  def delivery_action_gon
    gon.date_format = "YYYY/MM/DD"
    super
  end
end