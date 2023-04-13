class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

  def unit_price_to_dollars
    unit_price_in_cents = self.unit_price || 0
    dollars = unit_price_in_cents / 100.0
    format('%.2f', dollars)
  end
end
