class Admin::FinancialInstitutionsController < ApplicationController
  layout "admin/layouts/application"
  protect_from_forgery with: :exception
  skip_before_filter :authenticate_user!
  before_filter :authenticate_admin_administrator!
  before_action :load_financial_institutions, only: [:index]
  before_action :delivery_action_gon
  helper_method :page_entries_info

  module Constants
    ERROR_I18N_PREFIX = 'import_financial_institution.error'
    PER_PAGE = 10

    module CsvFormatInfo
      BANK_CODE = 0
      BANK_NAME = 3
      BANK_KANA = 2
      BRANCH_CODE = 1 
      BRANCH_NAME = 5
      BRANCH_KANA = 4
    end
  end

  def index
    respond_to do |format|
      @branches =
        Branch.search(params[:q]).result.page(params[:page]).per(
          params[:per_page] || Constants::PER_PAGE
        )

      format.html
      format.js if request.xhr?
    end
  end

  def import
    import_file = params[:import_file].presence
    @errors = []

    unless import_file
      @errors.push(t(:file_is_not_selected, Constants::ERROR_I18N_PREFIX))
    end
      
    unless @errors.presence
      import_main(import_file)
    end
      
    redirect_to action: 'index'
  end
  
  def redirect_path
    admin_financial_institutions_path
  end

  private
  def import_main(import_file)
    Bank.delete_all
    Branch.delete_all

    data = import_file.read

    CSV.parse(Kconv.toutf8(data)).each_with_index do |row, index|
      bank = Bank.where(code: row[Constants::CsvFormatInfo::BANK_CODE]).first

      unless bank.present?
        bank = Bank.create(
          code: row[Constants::CsvFormatInfo::BANK_CODE],
          name: row[Constants::CsvFormatInfo::BANK_NAME],
          kana: row[Constants::CsvFormatInfo::BANK_KANA]
        )
        unless bank.errors.messages.blank?
          @errors.push(bank.errors.messages.tap {|msg| msg[:line] = index})
          next
        end
      end

      branch = Branch.create(
        bank_id: bank.id,
        code: row[Constants::CsvFormatInfo::BRANCH_CODE],
        name: row[Constants::CsvFormatInfo::BRANCH_NAME],
        kana: row[Constants::CsvFormatInfo::BRANCH_KANA]
      )

      unless branch.errors.messages.blank?
        @errors.push(branch.errors.messages.tap {|msg| msg[:line] = index})
      end
    end
  end

  def load_financial_institutions
    @branches = Branch.all
  end

  def delivery_action_gon
    gon.controller_name = controller_name
    gon.action_name = action_name
  end

  def page_entries_info
    total_count =  Branch.count
    per_page = params[:per_page].present? ? params[:per_page].to_i : Constants::PER_PAGE
    page = params[:page].present? ? params[:page].to_i : 1
    p = {
      entry_name: t('admin.financial_institutions.model_name'),
      count: total_count,
      first: ((per_page * (page-1)) + 1),
      last:  (per_page * page) <= total_count ? (per_page * page) : total_count
    }

    if total_count < per_page
      k = 'one_page.display_entries.' + (total_count == 0 ? 'zero' : 'other')
    else
      k = 'more_pages.display_entries'
    end
    
    return t('views.page_entries_info.' + k, p)
  end
end
