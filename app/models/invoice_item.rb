class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  validates_presence_of :quantity, :unit_price, :status
  enum status: ["pending", "shipped", "packaged"]
  
  def item_name
    item.name
  end
end
