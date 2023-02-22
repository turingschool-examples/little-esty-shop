class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
	has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


  def top_five_customers
		# top_five = customers.joins(:transactions).where(transactions: {result: "success"}).group(:id).order('count(transactions.id) desc').limit(5)                
    # require 'pry'; binding.pry
    # top_five.joins(:transactions).count(:transactions)
    # customers.joins(:transactions).where(transactions: {result: "success"}).group(:id).count(:transactions)

    customers.select("customers.*, count(transactions) as trans_count")
             .joins(:transactions)
             .where(transactions: {result: "success"})
             .group(:id)
             .order("trans_count desc")
             .limit(5)
	end
end
