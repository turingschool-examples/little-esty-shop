class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  
  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
end
