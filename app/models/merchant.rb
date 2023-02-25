class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def mech_top_5_successful_customers
    
    # customers.joins(:transactions)

    # binding.pry

    # customers.top_5_successful_customers
    invoices.joins(:customer, :transactions)
    .select("customers.*, COUNT(transactions.id) AS transaction_count")
    .where(transactions: {result: 0})
    .group("customers.id")
    .order("transaction_count DESC")
    .limit(5)
  end

end
