class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  enum active_status: { enabled: 0, disabled: 1 }

  def items_not_shipped_sorted_by_date
    items.joins(:invoices).where.not(invoice_items: {status: 2}).order("invoices.created_at")
  end
end