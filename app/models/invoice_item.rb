class InvoiceItem < ApplicationRecord
  enum status: { packaged: 0, pending: 1, shipped: 2 }
  belongs_to :invoice
  belongs_to :item

  def display_price
    cents = self.unit_price
    '%.2f' % (cents /100.0)
  end
end 