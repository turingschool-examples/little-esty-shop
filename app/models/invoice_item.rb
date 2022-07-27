class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  
  belongs_to :item
  belongs_to :invoice

  enum status: { "pending": 0, "packaged": 1, "shipped": 2 }
end
