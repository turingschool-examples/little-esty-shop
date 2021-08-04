class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer

  validates :status, presence: true
  enum status: [ :in_progress, :completed, :cancelled ]

  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end

  def self.incomplete_invoices_by_date
    joins(:invoice_items)
    .where.not(invoice_items: {status: :shipped})
    .select('invoices.*')
    .group(:id)
    .order(:created_at)
  end
end
