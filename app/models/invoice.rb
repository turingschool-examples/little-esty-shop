class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
  has_one :merchant, through: :items

  enum status: ["cancelled", "in progress", "completed"]
  
  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end

  def self.incomplete_invoices
    joins(:invoice_items, :items).where.not("invoice_items.status = 2").distinct.order(:created_at)
  end
end
