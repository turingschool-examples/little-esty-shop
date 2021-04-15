class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name, :last_name

  def self.top_customers
    joins(:transactions)
    .where({transactions:{result: "success"} })
    .group(:id)
    .select("customers.*, count('transactions.results') as top_result")
    .order(top_result: :desc)
    .limit(5)
  end
end
