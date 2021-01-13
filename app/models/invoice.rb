class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items

  has_many :transactions
  belongs_to :customer
  belongs_to :merchant

  enum status: ['in progress', 'completed', 'cancelled']

  def self.incomplete_invoices
    Invoice.where(status: "in progress").order(created_at: :asc)
  end

  def self.top_sales_day
    joins(:transactions).where(transactions: {result: 0}).select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price)").group(:created_at).order(sum: :desc, created_at: :desc).first.created_at
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end
end
