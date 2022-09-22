class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :discount_percent, :quantity_threshold
  validates_numericality_of :discount_percent, :quantity_threshold
end