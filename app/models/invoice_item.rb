class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
  validates_presence_of :item_id
  validates_presence_of :invoice_id

  belongs_to :item
  belongs_to :invoice

  enum status: {"In Progress" => 0, "Completed" => 1, "Cancelled" => 2}
end
