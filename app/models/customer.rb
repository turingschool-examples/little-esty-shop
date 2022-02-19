class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions,through: :invoices

  def name
    first_name + " " + last_name
  end

  def transaction_count
    transactions.count
  end

  def successful_transactions_count
    transactions.where(result: 1).count
  end
  
end
