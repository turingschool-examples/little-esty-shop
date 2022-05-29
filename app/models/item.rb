class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

  def unit_price_to_dollars
    price = self.unit_price / 100.00
  end
end