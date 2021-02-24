class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def self.top_five
    joins(invoices: :transactions)
    .where('transactions.result = ?', 0)
    .group(:id)
    .select('customers.id, first_name, last_name, count(transactions.id) as transaction_count')
    .order(transaction_count: :desc)
    .limit(5)
  end
end
