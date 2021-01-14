class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  enum status: [:disabled, :enabled]

  def enabled_items
    Item.all_enabled_items.where(merchant_id: self.id)
  end

  def disabled_items
    Item.all_disabled_items.where(merchant_id: self.id)
  end

  def best_customers
    Invoice.where(merchant_id: self.id)
           .joins(:transactions, :customer)
           .select('customers.*, count(transactions) as most_success')
           .where('transactions.result = ?', 0)
           .group('customers.id')
           .order('most_success desc')
           .limit(5)
  end

  def self.top_five
    joins(:transactions, :invoice_items)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .group(:id)
    .where('transactions.result = ?', 0)
    .order('total_revenue desc')
    .limit(5)
  end

  def best_day
    invoices
    .joins(:invoice_items)
    .select('invoices.created_at AS created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group('invoices.created_at')
    .max
    .clean_date
  end
end

# DELETE IF NOT NEEDED:
# Transaction.joins(invoice: :customer).select('customers.*, count(transactions) as total_success').where('transactions.result = ?', 1).group('customers.id').order('total_success DESC').limit(5)