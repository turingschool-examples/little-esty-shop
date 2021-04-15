class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def invoice_items_ready_to_ship
    invoice_items.where.not(status: :shipped)
   .joins(:invoice)
   .where('invoices.status = ?', Invoice.statuses[:completed])
  end
end
