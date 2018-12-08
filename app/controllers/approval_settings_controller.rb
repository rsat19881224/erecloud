class ApprovalSettingsController < BaseController
  before_action :load_object
  permit_attributes :approval_type, :first_approval_omitted

  class << self
    def create_approval_setting(company_id, product)
      used_attr = Product.attribute_names.grep /_used/
      menus = search_menu("common")
      
      used_attr.each do |attr|
        if product.read_attribute(attr)
          menus.concat(search_menu(attr.sub('_used', '')))
        end
      end
      
      menus.each do |menu|
        if ApprovalSetting.where(company_id: company_id).where(menu_id: menu.id).empty?
          ApprovalSetting.create(company_id: company_id, menu_id: menu.id, approval_type: "no_approval", one_phase_approval_skiped: true)
        end
      end
    end

    def search_menu(category)
      Menu.with_product_category(category).where(approval_setting_used: true)
    end
  end
end
