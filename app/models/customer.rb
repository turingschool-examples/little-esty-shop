class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def number_of_transactions
    Customer.select('customers.id as id, count(transactions) as transaction_count').where("transactions.result = '0'").joins(:invoices).group("customers.id").joins(:transactions).group("invoices.id").find_by(id: self.id).transaction_count
  end
  def self.top_5
    Customer.select("customers.id as id, customers.first_name as first_name, customers.last_name as last_name, count(transactions) as transaction_count").where("transactions.result = '0'").group("transactions.result").joins(:invoices).group("customers.id").joins(:transactions).order('transaction_count DESC').distinct.limit(10)
  end


end
