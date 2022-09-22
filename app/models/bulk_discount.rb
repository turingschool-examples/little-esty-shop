class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :percentage_discount, :quantity_threshold
  validates_numericality_of :percentage_discount, :quantity_threshold

end