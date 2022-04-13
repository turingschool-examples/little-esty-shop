class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def items_and_invoice_items
    items.joins(:invoice_items)
    .select('items.*, invoice_items.quantity, invoice_items.unit_price')
    .group('items.id')
  end

  def most_popular_items
    items.joins(:invoices, :transactions)
    .select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .where("transactions.result = 'success' AND invoices.status = 1")
    .group('items.id')
    .order('total_revenue desc')
    .limit(5)
  end
end
