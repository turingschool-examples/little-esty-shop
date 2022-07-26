class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, presence: true, numericality: true
  validates_presence_of :unit_price, presence: true, numericality: true
  validates_presence_of :status, presence: true, numericality: true
  
  belongs_to :item
  belongs_to :invoice

  enum status: { "pending":0, "packaged": 1, "shipped": 2 }
end
