class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :first_name, :last_name

  def self.favorite_customers(count)
    joins(invoices: :transactions).
    where(transactions: {result: true}).
    group(:id).select('customers.*, COUNT(transactions.created_at)').
    order('count desc').
    limit(count)
  end

  def self.count_successful_transactions(id)
    Customer.find(id).transactions.where(result: true).count
  end

  def self.top_customers
    joins(invoices: :transactions)
    .where(transactions: {result: true})
    .group(:id).select("customers.*, COUNT(transactions) AS top_customers")
    .order("top_customers desc")
    .limit(5)
  end

  def count_of_transactions
    self.transactions.count
  end
end

# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted
