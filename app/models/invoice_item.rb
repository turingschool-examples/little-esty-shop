class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates_numericality_of :quantity
  validates_numericality_of :unit_price
  enum status:["pending", "packaged", "shipped"]
end
