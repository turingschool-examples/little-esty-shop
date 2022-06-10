class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_numericality_of :discount_percentage, greater_than: 0
end
