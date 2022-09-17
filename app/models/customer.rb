class Customer < ApplicationRecord

  has_many :invoices
  has_many :transactions, through: :invoices

  def count_successful_transactions
    transactions.where
  end

end 
