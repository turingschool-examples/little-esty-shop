class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def successful_transaction_count
    transactions.where(transactions: {result: 0}).count
  end

end
