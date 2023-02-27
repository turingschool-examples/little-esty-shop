class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  enum status: [ "enabled", "disabled" ]

  def toggle_status
    self.status == "enabled" ? self.disabled! : self.enabled!
  end

  def mech_top_5_successful_customers
    invoices.joins(:customer, :transactions)
    .select("customers.*, COUNT(transactions.id) AS transaction_count")
    .where(transactions: {result: 0})
    .group("customers.id")
    .order("transaction_count DESC")
    .limit(5)
  end

  def self.group_by_status(status)
    where(status: status)
  end

  def self.top_five_revenue
    joins(:invoice_items, :transactions)
    .where('result = 0')
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .group(:id)
    .order('total_revenue desc')
    .limit(5)
  end
  
  def total_revenue
    self.invoices
    .joins(:invoice_items, :transactions)
    .where('transactions.result = 0')
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end