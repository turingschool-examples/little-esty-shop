class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_customers(number)
    Customer.joins(:transactions)
    .where("result = ?", "0")
    .group(:id)
    .select("customers.*, count(transactions) as number_of_transactions")
    .order("number_of_transactions" => :desc)
    .limit(number)
  end

  def number_of_successful_transactions
    transactions
    .where("result = ?", "0")
    .count
  end
end
