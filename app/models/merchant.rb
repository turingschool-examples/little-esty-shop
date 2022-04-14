class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def most_popular_items
    items.joins(invoices: :transactions)
      .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
      .where('transactions.result = ?', 'success')
      .group('items.id')
      .order('total_revenue desc')
      .limit(5)
  end
end
