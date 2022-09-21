class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices,   through: :invoice_items
  has_many :transactions, through: :invoices
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_numericality_of :unit_price

  def best_day
    invoices
    .joins(:transactions)
    .where(transactions: {result: 1})
    .select('DATE(invoices.created_at) as created_date, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group('created_date').order('revenue desc, created_date desc').first.created_date
  end
end

