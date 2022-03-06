class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, packaged: 1, shipped: 2 }
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :bulk_discounts, through: :merchant 

  def get_name_from_invoice
    item.name
  end

  def display_price
    cents = self.unit_price
    '%.2f' % (cents / 100.0)
  end
end
