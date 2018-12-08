class DefaultPayableSite < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  belongs_to :company
  belongs_to :trader

  scope :of_ours, ->(company) { where(company_id: company.id, setting_type: 0) }
  scope :of_traders, ->(trader) { where(trader_id: trader.id, setting_type: 1) }

  enumerize(
    :contract_credit_category,
    in: Settings.enumerize_options.default_payable_site.contract_credit_categories,
    scope: true
  )
  enumerize(
    :site_designation_method,
    in: Settings.enumerize_options.default_payable_site.site_designation_methods,
    scope: true
  )
  enumerize(
    :holiday_transfer_method,
    in: Settings.enumerize_options.default_payable_site.holiday_transfer_methods,
    scope: true
  )

  scope :of_ours, ->(company) { where(company_id: company.id) }

  def ransackable_attributes(auth_object = nil)
    %w(company_id obligation_division, date_designation_division contract_credit_category)
  end

  def ransackable_associations(auth_object = nil)
    %w(company)
  end

  class << self
    def pre_create_default_payable_sites(company)
      all_categories = DefaultPayableSite.contract_credit_category.options.map {|c| c.second }
      all_categories -= [DefaultPayableSite.contract_credit_category.all]
      all_categories.each do |category|
        create(
          company_id: company.id,
          setting_type: 0,
          site_designation_method: DefaultPayableSite.site_designation_method.no_designation,
          contract_credit_category: category,
          holiday_transfer_method: DefaultPayableSite.holiday_transfer_method.following_business_day
        )
      end
    end
  end
end
