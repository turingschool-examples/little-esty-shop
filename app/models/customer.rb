class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name, :last_name


  def self.top_five_customers
    joins(:transactions).
    where({ transactions: { result: "success" } }).
    group(:id).
    select("customers.*, count('transaction.result') as top_five").
    order(top_five: :desc).
    limit(5)
  end
end
