class InvoiceItem < ApplicationRecord
  enum status: { Pending: 0, Packaged: 1, Shipped: 2 }
  belongs_to :invoice
  belongs_to :item

  has_many :merchants, through: :item

end 