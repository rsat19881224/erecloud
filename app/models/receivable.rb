class Receivable
  
  include ActiveModel::Model
  attr_accessor :id,
                :company_id,
                :recording_institution_id,
                :recording_number,
                :accrual_type,
                :trader_id,
                :opt_trader,
                :trader,
                :occurred_on,
                :last_transferred_on,
                :transfer_warrant,
                :due_become_on,
                :settled_on,
                :site_division,
                :company_bank_id,
                :issue_money,
                :ref_no,
                :transfer_restricted,
                :debtors_department_id,
                :operating_item_id,
                :remark1,
                :remark2,
                :remark3,
                :assignor_name,
                :residual_money,
                :section_breakdowns,
                :guarantors
  
  def persisted?
    self.id.present?
  end
  def initialize(attributes={})
    super
  end
  def guarantors_attributes=(attributes)
    @guarantors ||= []
    attributes.each do |i, guarantors_params|
      @guarantors.push(Guarantor.new(guarantors_params))
    end
  end
  def section_breakdowns_attributes=(attributes)
    @section_breakdowns ||= []
    attributes.each do |i, section_breakdown_params|
      @section_breakdowns.push(SectionBreakdown.new(section_breakdown_params))
    end
  end
  def trader_attributes=(attribute)
    @trader ||= []
    attribute.each do |i, trader_param|
      @trader.push(Trader.new(trader_params))
    end
  end
  def opt_trader_attributes=(attributes)
    @opt_trader||= []
    attributes.each do |i, opt_trader_params|
      @trader.push(Trader.new(opt_trader_params))
    end
  end
  def self.reflect_on_association(association)
    data = { klass: association.to_s.classify.constantize }
    OpenStruct.new data
  end
  def save 
   if valid?
      persist!
      true
   end
   false 
  end

private
  def persist!
    # TODO: 1.条件分岐の追加
    # TODO:2.Stateオブジェクト化
    Ebill.create(
      company_id: company_id, 
      # FIXME: magic-number
      company_division: 2,
      data_type: 1,
      settlement_type: 0,
      recording_institution_id: recording_institution_id,
      recording_number: recording_number,
      accrual_type: accrual_type,
      # XXX: 0が譲受前提
      transferred: accrual_type == 0 ? 1 : 0,
      #occurance_type: accrual_type == 0 ? 1 : 0,
      occurred_on:  occurred_on,
      last_transferred_on: accrual_type == 0 ? last_transferred_on : nil,
      
    )
  end

  # TODO: 外出ししてもいいかもね
  class Trader
    include ActiveModel::Model
    attr_accessor :name, :kana, :bank_code, :bank_name, :branch_code, :branch_name, :account_type, :account_number, :user_number
  end

end
