class Merchant < ApplicationRecord

  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  enum status: [:disabled, :enabled]

  def best_customers
    Invoice.where(merchant_id: self.id)
           .joins(:transactions, :customer)
           .select('customers.*, count(transactions) as most_success')
           .where('transactions.result = ?', 0)
           .group('customers.id')
           .order('most_success desc')
           .limit(5)
  end

  def self.items_ready_to_ship(id)
            where(id: id)
           .joins(invoices: :items)
           .select('items.name')
           .where('invoice_items.status < ?', 2)
           .group('items.name, merchants.id')
  end

  def invoices_for_items_rdy_to_ship(m_id, name)
    Invoice.where(merchant_id: m_id)
           .joins(:items)
           .select(:id, :created_at)
           .where('items.name = ?', name)
           .order('created_at asc')
  end

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
