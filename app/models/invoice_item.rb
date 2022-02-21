class InvoiceItem < ApplicationRecord
  enum status: { Pending: 0, Packaged: 1, Shipped: 2 }
  belongs_to :invoice
  belongs_to :item

  def get_name_from_invoice
    item.name
  end

  
end
