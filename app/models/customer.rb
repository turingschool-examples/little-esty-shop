class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  def self.top_5_by_transactions
    joins(:transactions)
    .select("customers.*, count(transactions.id) AS transaction_count")
    .group(:id)
    .order("transaction_count DESC")
    .limit(5)  
  end

  def transaction_count
    transactions.count
  end
end