class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: [ :disabled, :enabled ]

  def self.top_five_by_successful_transaction_count
    joins(:transactions, :customers)
    .where(transactions: {result: "success"})
    .group("customer.id")
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
end