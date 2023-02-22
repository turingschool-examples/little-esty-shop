class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
	has_many :customers, through: :invoices


  def top_five_customers
		customers.joins(:transactions).where(transactions: {result: "success"}).group(:id).order('count(transactions.id) desc').limit(5)                
	end
end
