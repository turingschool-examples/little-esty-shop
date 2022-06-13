class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  validates_presence_of :threshold, :discount_percentage
  validates_numericality_of :threshold, greater_than_or_equal_to: 1
  validates_numericality_of :discount_percentage, greater_than: 0, less_than: 100

end
