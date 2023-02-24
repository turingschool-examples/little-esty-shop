class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :invoices

  def self.top_five_customers
    joins(:transactions).select("customers.*, count(result) as result_count").where(transactions: {result: 'success'}).group(:id).order("count(result) desc").limit(5)
  end
end
