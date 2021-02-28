class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def most_popular_items
    invoice_items.joins(:item, :transactions)
      .where('transactions.result = ?', "success")
      .group('items.id')
      .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .order('revenue DESC')
      .limit(5)
  end

  def find_top_customers
    customers.joins(:invoices, :transactions)
      .where('transactions.result = ?', "success")
      .group('customers.id')
      .select('customers.*, count(*) AS transaction_count')
      .order('transaction_count DESC')
      .limit(5)
  end

  def items_not_shipped
    items.joins(:invoice_items)
    .joins(:invoices)
    .where('invoice_items.status != ?', 2)
    .select('items.*, invoice_items.invoice_id AS invoice_id, invoices.created_at AS invoice_created_at')
    .order('invoice_created_at')
  end

  def enabled_items
    items.where(status: true)
  end

  def disabled_items
    items.where(status: false)
  end
end
