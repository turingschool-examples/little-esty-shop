class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  
  # Can we use ruby for this method?
  def name
    first_name + " " + last_name
  end

  def self.top_five_customers
    joins(:transactions)
    .where("transactions.result = ?", true)
    .group("customers.id")
    .select("customers.*, count('transactions.result') as top_result")
    .order(top_result: :desc)
    .limit(5)
  end

  def successful_count
    transactions
    .where("transactions.result = ?", true)
    .count(:transactions)
  end
end
