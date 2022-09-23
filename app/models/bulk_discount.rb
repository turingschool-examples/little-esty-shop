class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchants
  has_many :invoice_items, through: :items
  has_many :invoices, through: :merchant
  validates_presence_of :percentage_discount, :quantity_threshold
  validates_numericality_of :percentage_discount, :quantity_threshold

end