class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: [ :disabled, :enabled ]

  def top_five_customers_by_successful_transaction_count
    customers.joins(:transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .select("customers.*, count(transactions.id) as successful_transaction_count")
    .order(successful_transaction_count: :desc)
    .limit(5)
  end

  def self.top_five_by_merchant_revenue
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_rev")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: :success})
    .group(:id)
    .order(total_rev: :desc)
    .limit(5)
  end

  # def not_shipped_by_date
  #   require "pry";binding.pry
  #   joins(:invoice_items, :items, :invoices)
  #   .select('invoices.created_at', 'items.name', 'invoices.id')
  #   .order(':invoices.created_at')
  #   .where(status: "created_at")
  # end
end
