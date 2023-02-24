class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five_customers
    joins(:transactions).select("customers.*, count(result) as result_count").where(transactions: {result: 'success'}).group(:id).order("count(result) desc").limit(5)
  end
end
