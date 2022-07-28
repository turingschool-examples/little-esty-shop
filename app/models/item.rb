class Item < ApplicationRecord
  enum status: { Disabled: 0, Enabled: 1 }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def total_revenue
    joins(:invoices).where(invoice: { status: 2 }).sum('quantity * unit_price')
  end
end
