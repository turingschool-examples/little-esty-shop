class Discount < ApplicationRecord
  validates_numericality_of :bulk_discount, less_than: 1
  validates_numericality_of :bulk_discount, greater_than: 0
  validates_numericality_of :item_threshold, greater_than: 0
  
  belongs_to :merchant
end
