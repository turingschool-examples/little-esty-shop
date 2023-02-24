class Merchant < ApplicationRecord
  validates :name, presence: true
  enum status: [ "active", "disabled" ]
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
  customers.joins(:transactions).where(transactions: {result: 'success'}).select("customers.*, count(DISTINCT transactions.id) as transactions_count").group("customers.id").order("transactions_count desc").limit(5)
  #  require 'pry'; binding.pry
  end

  def customer_successful_transactions(customer_id)
    # require 'pry'; binding.pry
    Transaction.joins(invoice: [:items, :customer]).where(result: 'success').where(items: { merchant_id: self.id }).where(customers: { id: customer_id }).distinct.count
  end
end
