class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def display_price
    cents = self.unit_price
    '%.2f' % (cents /100.0)
  end
end
