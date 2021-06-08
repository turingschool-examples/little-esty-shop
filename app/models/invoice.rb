class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, dependent: :destroy

  enum status: ['In Progress', 'Completed', 'Cancelled']

  def self.ordered_invoices_not_shipped
    joins(:invoice_items)
      .where('invoice_items.status <> ?', 2)
      .order(created_at: :asc)
      .distinct
  end

  def self.expected_invoice_revenue(invoice_id)
    joins(:invoice_items)
      .group(:id)
      .select('sum(invoice_items.quantity*invoice_items.unit_price) as invoice_revenue')
      .where('invoice_items.invoice_id = ?', invoice_id)
  end

  def self.top_five_best_day(merchant_id)
    joins(:invoice_items, :merchants, :transactions)
      .group('invoices.id, merchants.id')
      .select('invoices.*, merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue')
      .where('transactions.result = ?', 0)
      .order(total_revenue: :desc)
      .where('merchants.id = ?', merchant_id)
      .first
      .created_at
  end
end
# Invoice.joins(:invoice_items).group(:id).select('invoices.*,sum(invoice_items.quantity*invoice_items.unit_price) as invoice_revenue').where('invoice_items.invoice_id = ?', params)
# Invoice.joins(:invoice_items).select('invoices.*,invoice_items.*').where('invoice_items.invoice_id = ?', params)
# Invoice.joins(:invoice_items).where('invoice_items.status <> ?', 2).order(created_at: :desc).distinct

# Invoice.joins(:invoice_items, :merchants, :transactions).group('invoices.id, merchants.id').select('invoices.*, merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as total_revenue').where('transactions.result = ?', 0).order(total_revenue: :desc).where('merchants.id = ?', merchant_id).first.created_at
