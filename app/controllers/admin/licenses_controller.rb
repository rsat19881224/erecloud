class Admin::LicensesController < Admin::BaseController
  permit_attributes  :product_id, :number_of_license, :period_of_service, :use_starting_date, :use_end_date, :license_type
  before_action :load_company
  before_action :assign_attributes, only: [:create, :update]
  before_action :create_approval_setting, only: [:create, :update]
  helper_method :format_date_default
  skip_before_action :set_company
  def index
    @licenses = License.where(company_id: @company.id).search.result.page(params[:page]).per(params[:per_page] || 10)
  end

  def redirect_path
    polymorphic_path([:admin, @company, License])
  end

  def create_approval_setting
    Product.find_by_id(@instance.product_id).tap do |product|
      ApprovalSettingsController.create_approval_setting(@company.id, product) if product
    end
  end

  def delivery_action_gon
    gon.date_format = "YYYY/MM/DD"
    super
  end

  private
  def load_company
    @company = Company.find(params[:company_id])
  end

  def assign_attributes
    @license.company = @company
  end

  def format_date_default(date)
    date.strftime(t('date.formats.default'))
  end
end
