module MasterSearch
  module Initialize
    extend ActiveSupport::Concern
    
    included do |klass|
      class_attribute :_search_master_models
      before_action :initialize_search, only: [:new, :edit]
    end

    module ClassMethods
      def search_master_models(*search_master_models)
        self._search_master_models = search_master_models
      end
    end

    private
    def initialize_search
      return unless self._search_master_models.presence
      self._search_master_models.each do |model_name|
        model = Object.const_get(model_name.to_s.camelize) rescue nil
        if model
          q = instance_variable_set("@#{model_name.to_s}_q", model.search(params[:q]))
          instance_variable_set(
            "@#{model_name.to_s.pluralize}",
            q.result.page(params[:page]).per(params[:per_page] ||= 10)
          )
        end
      end
    end
  end

  module BankSearch
    def search_bank
      respond_to do |format|
        bank_info = (params[:selected_bank] || {}).select {|k, v| v.presence}
        if bank_info.presence
          params[:q] = (params[:q] || {}).merge(bank_info)
        end

        if params.try(:[], :selected_bank).try(:[], :modalid).present?
          local = {modalid: params[:selected_bank][:modalid]}
        elsif params.try(:[], :reviewed).try(:[], :modalid).present?
          local = {modalid: params[:reviewed][:modalid]}
        else
          local = {}
        end

        @bank_q = Bank.search(params[:q] || {})
        @banks  = @bank_q.result.page(params[:page]).per(params[:per_page] ||= 10)

        format.js { render partial: 'shared/banks/search_bank', locals: local} if request.xhr?
      end
    end
  end

  module BranchSearch
    def search_branch
      respond_to do |format|
        if params[:selected_bank]
          bank = Bank.search(params[:selected_bank]).result.first
          if params[:q]
            params[:q].store('bank_id_eq', bank.id)
          else
            params[:q] = {bank_id_eq: bank.id}
          end
        end
        @branch_q = Branch.search(params[:q])
        @branches = @branch_q.result.page(params[:page]).per(params[:per_page] ||= 10)

        s_bank = params[:selected_bank]
        if s_bank[:modalid].present?
          local = {modalid: s_bank[:modalid]}
          format.js { render partial: 'shared/branches/search_branch', locals: local} if request.xhr?
        else
          format.js { render partial: 'shared/branches/search_branch' } if request.xhr?
        end
      end
    end
  end

  module DepartmentSearch
    def search_department
      respond_to do |format|
        department_info = (params[:selected_department] || {}).select {|k, v| v.presence}
        if department_info.presence
          params[:q] = (params[:q] || {}).merge(department_info)
        end

        @department_q = Department.of_ours(@my_company).search(params[:q])
        @departments  = @department_q.result.page(params[:page]).per(params[:per_page] || 10)

        local = {}
        if department_info[:modalid].presence
          local[:modalid] = department_info[:modalid]
        end

        format.js { render partial: 'shared/departments/search_department', locals: local } if request.xhr?
      end
    end
  end
end

