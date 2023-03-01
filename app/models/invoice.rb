class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: ["in progress", "cancelled", "completed"]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
end
