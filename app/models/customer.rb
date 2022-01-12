class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

   def self.top_5
    joins(invoices: :transactions)
    .where('transactions.result = ?', 'success')
    .select("customers.*, count(transactions.id) as transaction_count")
    .group(:id)
    .order(transaction_count: :desc)
    .limit(5)
  end
end
