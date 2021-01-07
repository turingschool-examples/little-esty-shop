class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  
  enum status: [ :cancelled, :in_progress, :completed ]

  def date
    created_at.strftime("%A, %b %d, %Y")
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .order(created_at: :asc)
    .where.not(status: 2)
    .where.not("invoice_items.status = ?", 2)
    .distinct
  end

  def self.best_day
    joins(:invoice_items)
    .select('invoices.created_at AS created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group('invoices.created_at')
    .max
    .date
    #.order(total_revenue: :desc)
    #.max
    #.pluck(:created_at)
  end
end