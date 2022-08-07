class BulkDiscount < ApplicationRecord
  validates :percentage, presence: true
  validates :quantity_threshold, presence: true
  belongs_to :merchant
end