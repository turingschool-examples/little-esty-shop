class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :merchant_id, presence: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: { "enabled": 0, "disabled": 1 }

  def most_sales_date
    invoices
    .joins(:transactions)
    .where('transactions.result = ?', 'success')
    .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group('invoices.created_at')
    .order('revenue desc, invoices.created_at desc')
    .first.created_at.strftime("%m/%d/%y")
  end
end
