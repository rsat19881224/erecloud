class OperativeSetting < ActiveRecord::Base
  extend Enumerize
  acts_as_paranoid

  belongs_to :company

  scope :of_ours, ->(company) { where(company_id: company.id) }
  enumerize :date_display_format, in:  Settings.enumerize_options.date_display_formats

  validates :company_id, presence: true
  validates :company_name1, presence: true
  validates :postal_code, format: {with: /\A\d{3}\-\d{4}\z/, allow_nill: true}

  class << self
    def pre_create_operative_setting(company)
      create(
        company_id: company.id,
        company_name1: company.name,
        postal_code: company.postal_code,
        address1: I18n.t(company.prefecture, scope: 'enumerize.prefecture') + company.address,
        person_in_charge_name: company.charge_name,
        person_in_charge_official_title: company.affiliated_post,
        date_display_format: OperativeSetting.date_display_format.anno_domini,
        is_transfer_fixed_date: true,
        is_use_section_authority: false
      )
    end
  end
end
