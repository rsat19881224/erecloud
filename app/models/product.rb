class Product < ActiveRecord::Base
  acts_as_paranoid
  validates :name, uniqueness: true

  scope :licensed, ->(company) { where(License.where(company_id: company.id).where(License.arel_table[:product_id].eq(Product.arel_table[:id])).exists) } 
  scope :unlicensed, ->(company) { where(License.where(company_id: company.id).where(License.arel_table[:product_id].eq(Product.arel_table[:id])).exists.not) }
end
