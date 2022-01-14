class Merchant < ApplicationRecord

  has_many(:items)
  has_many :discounts
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: {"disabled" => 0, "enabled" => 1}

  def favorite_customers
    customers
    .joins(invoices: :transactions)
    .where('transactions.result = ?', 'success')
    .group('customers.id')
    .order('transactions.count DESC')
    .limit(5)
  end

  def items_ready_to_ship
    invoice_items
    .order(created_at: :asc)
    .where.not(status: 'shipped')
  end

  def total_revenue
     invoice_items.sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.only_enabled
    where(status: 1)
  end

  def self.only_disabled
    where(status: 0)
  end

  def self.top_5_total_revenue
    joins(items: [invoices: :transactions])
    .where(transactions: {result: "success"})
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .group(:id)
    .order("total_revenue DESC")
    .limit(5)
  end

  def best_day
    invoices.where(status: "completed")
            .joins(:transactions)
            .where(transactions: {result: "success"})
            .group(:id)
            .select("invoices.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue_1")
            .order("total_revenue_1 DESC, invoices.created_at DESC")
            .first.created_at.strftime("%A, %B %d %Y")
  end
end
