class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def price_in_dollars
    unit_price.to_f / 100
  end
end
