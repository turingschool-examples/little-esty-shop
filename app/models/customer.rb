class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def transaction_count
    self.transactions.count
  end

  def self.order_by_transactions
    self.order(transaction_count: :desc).limit(5)
  end
end
