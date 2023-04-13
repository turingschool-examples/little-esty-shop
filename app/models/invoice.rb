class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer

  enum status: ["cancelled", "in progress", "completed"]
  
  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end
end
