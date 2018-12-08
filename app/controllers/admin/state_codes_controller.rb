class Admin::StateCodesController < Admin::BaseController
  permit_attributes :code, :division, :bill, :ebill, :factoring, :cash_payment

  def edit
    gon.editing = true
    gon.state_code_division = @state_code.division
    super
  end
end
