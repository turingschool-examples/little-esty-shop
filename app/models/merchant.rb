class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  enum active_status: { enabled: 0, disabled: 1 }

  def items_not_shipped_sorted_by_date
    invoices.where.not(invoice_items: {status: 2}).order("invoices.created_at")
  end

  def self.active
    where(active_status: :enabled)
  end

  def self.inactive
    where(active_status: :disabled)
  end
end