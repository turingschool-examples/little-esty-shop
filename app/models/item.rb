class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def price_convert
    dollars = unit_price.to_f/100
    '%.2f' % dollars
  end
end
