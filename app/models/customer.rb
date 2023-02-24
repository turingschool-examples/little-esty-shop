class Customer < ApplicationRecord

  has_many :invoices, dependent: :destroy
	has_many :transactions, through: :invoices

  def self.top_five_customers
    x = joins(:transactions)
    .select("customers.*, count(DISTINCT transactions.id) as trans_count")
    .where("transactions.result = 0")
    .group("customers.id")
    .order("trans_count desc")
    .limit(5)
	end
  
end
