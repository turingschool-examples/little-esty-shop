class InvoiceItem < ApplicationRecord
  enum status: { packaged: 0, pending: 1, shipped: 2 }
  belongs_to :invoice
  belongs_to :item

  def find_merchant_item
    Item.find(self.item_id)
  end
end 