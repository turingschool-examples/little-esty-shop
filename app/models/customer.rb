class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.favorite_customers
    select("customers.*, count(*) AS count").joins("JOIN transactions ON transactions.invoice_id = invoices.id").where(transactions: {result: 0}).group(:id).order("count DESC").limit(5)
  end

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

  def name
    first_name + " " + last_name
  end

end
