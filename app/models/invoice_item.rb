class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  
  enum status: ["pending", "shipped", "packaged"]
  
  def item_name
    item.name
  end
end
