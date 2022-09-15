class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.top_customers
    
    Customer.select("customers.*", 'count(transactions)').joins(invoices: :transactions).where('transactions.result' => 1).order('count desc').group(:id).limit(5)
  end
end
# As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted