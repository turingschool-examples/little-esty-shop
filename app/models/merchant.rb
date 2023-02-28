class Merchant < ApplicationRecord
  validates :name, presence: true
  enum status: [ "disabled", "active" ]
  has_many :items
	has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
    customers.joins(:transactions).where(transactions: {result: 'success'}).select("customers.*, count(DISTINCT transactions.id) as transactions_count").group("customers.id").order("transactions_count desc").limit(5)
  end

  def customer_successful_transactions(customer_id)
    Transaction.joins(invoice: [:items, :customer]).where(result: 'success').where(items: { merchant_id: self.id }).where(customers: { id: customer_id }).distinct.count
  end

	def self.active_merchants
		Merchant.where(status: 1)
	end

	def self.disabled_merchants
		Merchant.where(status: 0)
	end

  def self.top_five_merchant_by_rev
    joins(:transactions)
		.where(transactions: {result: 0})
		.select("merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) as revenue")
		.group(:id)
		.order("revenue DESC")
		.limit(5)
  end

  def date_with_most_revenue
    # require 'pry'; binding.pry
    invoices
    .where(status: "completed")
    .select("invoices.created_at, SUM(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group("invoices.created_at")
    .order(revenue: :desc)
    .limit(1)
    .first.created_at.strftime("%m/%d/%Y")
    
  end
end
