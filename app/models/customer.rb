class Customer < ApplicationRecord

  has_many :invoices, dependent: :destroy
	has_many :transactions, through: :invoices


  def self.top_five_customers

    select("customers.*, count(transactions) as trans_count")
             .joins(:transactions)
             .where(transactions: {result: "success"})
             .group(:id)
             .order("trans_count desc")
             .limit(5)
	end
  
end
