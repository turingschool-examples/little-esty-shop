class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: ["cancelled", "in progress", "completed"]

  def self.incomplete_invoices
    joins(:invoice_items).select('invoices.id', 'invoices.created_at').where('invoice_items.status != ?', 2).distinct.order(created_at: :asc)
  end

  def self.total_revenue(invoice_id)
    Invoice.joins(:transactions, :invoice_items).where("invoices.id = ? AND transactions.result = ?", invoice_id, "success").sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
