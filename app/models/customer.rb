class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_customers
    joins(:transactions)
    .where(transactions: {result: 'success'})
    .select("customers.*, count(DISTINCT transactions.id) as transaction_count")
    .group("customers.id")
    .order("transaction_count desc").limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
