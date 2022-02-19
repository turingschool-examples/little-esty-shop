class InvoiceItem < ApplicationRecord
  enum status: { Packaged: 0, Pending: 1, Shipped: 2 }
  belongs_to :invoice
  belongs_to :item

end 