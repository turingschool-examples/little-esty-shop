class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoices, through: :invoice_items
  has_many :invoice_items


  def unit_price_to_currency
    "%.2f" % (unit_price.to_f/100).truncate(2)
  end
end
