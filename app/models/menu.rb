class Menu < ActiveRecord::Base
  acts_as_paranoid
  extend Enumerize

  enumerize :manager_division, in: Settings.enumerize_options.menu.manager_divisions, scope: true
  enumerize :product_category, in: Settings.enumerize_options.menu.product_categories, scope: true
  enumerize :extend_type, in: Settings.enumerize_options.menu.extend_types, scope: true

  class << self
    def our_menus(company)
      search_attr = Product.attribute_names.grep /_used/
      products = License.of_ours(company).map {|l| Product.find_by_id(l.product_id) }
      menus = Menu.with_product_category(Menu.product_category.common)
      
      products.each do |product|
        search_attr.each do |attr|
          menus.concat(Menu.with_product_category(attr.sub('_used', ''))) if product.read_attribute(attr)
        end
      end
      menus
    end
  end
end
