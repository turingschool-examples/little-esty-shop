class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five_customers
    joins(:transactions)
    .where('result = ?', 0)
    .group(:id)
    .select("customers.*, count('transaction.result') as top_five")
    .order(top_five: :desc)
    .limit(5)
  end

# merchant.invoices.joins(:transactions, :customer)
# .where('result = ?', 0)
# .group("customers.id")
# .select("customers.*, count(transactions.result) as transaction_count")
# .order(transaction_count: :desc)
# .limit(5)

  def successful_transactions_count
    transactions.where('result = ?', 0)
    .count
  end

  def name
    "#{first_name} #{last_name}"
  end
end
