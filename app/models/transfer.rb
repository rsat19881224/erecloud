class Transfer
  include ActiveModel::Model
  attr_accessor :id,
                :recording_institution_id,
                :trader_id,
                :transferred_on,
                :company_bank_id,
                :guaranteed,
                :trader,
                :company_bank

  def trader_attributes=(attribute)
    @trader = Trader.new(attribute)
  end

  def company_bank_attributes=(attribute)
    @company_bank = CompanyBank.new(attribute)
  end
  # TODO: 外出ししてもいいかもね
  class CompanyBank
    include ActiveModel::Model
    attr_accessor :code, :name, :kana, :bank_code, :bank_name, :branch_code, :branch_name, :account_type, :account_number, :user_number
  end

  class Trader
    include ActiveModel::Model
    attr_accessor :code, :name, :kana, :bank_code, :bank_name, :branch_code, :branch_name, :account_type, :account_number, :user_number
  end

end
