class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  enum status: ['in progress', 'completed', 'cancelled']

  def self.ordered_invoices_not_shipped
    joins(:invoice_items)
      .where.not('invoice_items.status = ?', 2)
      .order(created_at: :desc)
      .distinct
  end

  def self.expected_invoice_revenue(params)
    joins(:invoice_items)
      .group(:id)
      .select('sum(invoice_items.quantity*invoice_items.unit_price) as invoice_revenue')
      .where('invoice_items.invoice_id = ?', params)
  end
end

# Invoice.joins(:invoice_items).group(:id).select('invoices.*,sum(invoice_items.quantity*invoice_items.unit_price) as invoice_revenue').where('invoice_items.invoice_id = ?', params)
