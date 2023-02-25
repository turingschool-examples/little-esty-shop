class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  # has_one :transaction
  enum status: [ "in progress", "completed", "cancelled" ]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
end