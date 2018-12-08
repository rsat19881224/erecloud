class ReceivableSearch < EbillReceivableState
  include ActiveModel::Model
  attr_accessor :period_type_1,
                :period_1_from,
                :period_1_to,
                :period_type_2,
                :period_2_from,
                :period_2_to,
                :name_specified,
                :name_specified_words,
                :their_particulars,
                :state_code_id_eq_any,
                :transfer_date_from,
                :transfer_date_to,
                :discount_date_from,
                :discount_date_to,
                :transferee_trader_id_from,
                :transferee_trader_id_to,
                :transferee_name,
                :acquisition_division_eq_any,
                :cancel_flag,
                :recording_institutions_check

  belongs_to :state_code, primary_key: :code, foreign_key: :state_code_id
  belongs_to :recording_institution, primary_key: :code, foreign_key: :recording_institution_id

  def initialize(param_hash = {})
    super
    param_hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def receivable_search
    # 集計期間検索
    params_q = period_types()
    # 名称指定検索
    params_q = name_specifieds(params_q)
    # 検索パラメータ
    { g: {'0' => { m: 'and', g: { '0' => params_q, '1' =>  particulars_specified_params(params_q) } } } }
  end

  def transfer_search
    # 集計期間検索
    params_q = period_types()
    # 譲渡日付、譲渡先検索
    params_q = transfer_cancel_search()
    # 検索パラメータ
    { g: {'0' => { m: 'and', g: { '0' => params_q } } } }
  end

  # 決済取消の検索
  def settlement_search
    params_q = period_types()
    params_q = settlement_cancel_judge(params_q)
    params_q
  end
  
  private
  def period_types()
    params_q = Hash.new()

    (1..2).each {|t|
      period_type = send("period_type_#{t}").to_i
      period_from = send("period_#{t}_from")
      period_to = send("period_#{t}_to")

      # 発生日付
      if period_type == 2
        params_q[:occurred_on_gteq] = period_from
        params_q[:occurred_on_lteq] = period_to
      # 譲受日付
      elsif period_type == 3
        params_q[:transferred_on_gteq] = period_from
        params_q[:transferred_on_lteq] = period_to
        params_q[:acquisition_division_eq_any] = 3
      # 支払期日
      elsif period_type == 4
        params_q[:matured_on_gteq] = period_from
        params_q[:matured_on_lteq] = period_to
      # 支払日付
      elsif period_type == 5
        params_q[:settled_on_gteq] = period_from
        params_q[:settled_on_lteq] = period_to
      end
    }
    params_q
  end

  def name_specifieds(params_q)
    # 債務者名
    if @name_specified.to_i == 1
      params_q[:debtor_name_or_debtor_kana_cont] = @name_specified_words
    # 譲渡人名
    elsif @name_specified.to_i == 2
      params_q[:trader_name1_or_trader_name2_or_trader_kana_cont] = @name_specified_words
      params_q[:acquisition_division_eq] = 3
    end
    params_q
  end

  # てん末指定条件
  def particulars_specified_params(params_q)
    # OR条件検索パラメータ
    { g: { '0' => { m: 'or', g: { '0' => transfer(params_q), '1' => discount(params_q) } } } }
  end

  def transfer(params_q)
    params_transfer = Hash.new()
    # てん末コード
    code = params_q[:state_code_id_eq_any]
    # 譲渡コード
    transfer_code = StateCode.where(ebill: '譲渡').pluck(:code).first

    # 譲渡日付
    params_transfer[:transferred_on_gteq] = @transfer_date_from if @transfer_date_from.present?
    params_transfer[:transferred_on_lteq] = @transfer_date_to if @transfer_date_to.present?
    # 譲渡先
    params_transfer[:transferee_trader_id_gteq] = @transferee_trader_id_from if @transferee_trader_id_from.present?
    params_transfer[:transferee_trader_id_lteq] = @transferee_trader_id_to if @transferee_trader_id_to.present?
    # 譲渡先名
    params_transfer[:transferee_name1_or_transferee_name2_or_transferee_kana_cont] = @transferee_name if @transferee_name.present?
    # てん末コード
    params_transfer[:state_code_id_eq] = transfer_code if (params_transfer.size > 0) or (code.present? and code.include?(transfer_code.to_s))

    params_transfer
  end

  def discount(params_q)
    params_discount = Hash.new()
    # てん末コード
    code = params_q[:state_code_id_eq_any]
    # 割引コード
    discount_code = StateCode.where(ebill: '割引').pluck(:code).first

    params_discount[:transferred_on_gteq] = @discount_date_from if @discount_date_from.present?
    params_discount[:transferred_on_lteq] = @discount_date_to if @discount_date_to.present?
    params_discount[:state_code_id_eq] = discount_code if (params_discount.size > 0) or (code.present? and code.include?(discount_code.to_s))

    params_discount
  end
  def transfer_cancel_search
    params_transfer = Hash.new()

    # 譲渡コード
    transfer_code = StateCode.where(ebill: '譲渡').pluck(:code).first

    # 譲渡日付
    params_transfer[:transferred_on_gteq] = @transfer_date_from if @transfer_date_from.present?
    params_transfer[:transferred_on_lteq] = @transfer_date_to if @transfer_date_to.present?
    # 譲渡先
    params_transfer[:transferee_trader_id_gteq] = @transferee_trader_id_from if @transferee_trader_id_from.present?
    params_transfer[:transferee_trader_id_lteq] = @transferee_trader_id_to if @transferee_trader_id_to.present?

    params_transfer
  end

  # 決済取消の判定
  def settlement_cancel_judge(params_q)
    transfer_code = StateCode.where(ebill: '決済').pluck(:code).first
    # 決済指示
    if cancel_flag.to_i == 0
      params_q[:residual_money_gt] = 0
    # 決済取消
    else
      params_q[:state_code_id_eq] = transfer_code
    end
    params_q
  end
end
