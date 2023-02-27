class Merchant < ApplicationRecord
  validates :name, presence: true
  enum status: [ "active", "disabled" ]
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
		Merchant.where(status: 0)
	end

	def self.disabled_merchants
		Merchant.where(status: 1)
	end
end
