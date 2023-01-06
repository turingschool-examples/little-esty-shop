class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  enum status: { 'in progress' => 0, completed: 1, cancelled: 2 }

  def self.incomplete_invoices
    Invoice.left_joins(:invoice_items).where.not('invoice_items.status = ?', 2).distinct.order(:updated_at)
  end

  def total_invoice_revenue
    number_to_currency(invoice_items.sum('invoice_items.quantity * invoice_items.unit_price')/100.0)
  end
end