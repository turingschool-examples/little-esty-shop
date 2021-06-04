class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  enum status: ["enable", "disable"]

  def price
    ((unit_price.to_f) / 100)
  end
end
