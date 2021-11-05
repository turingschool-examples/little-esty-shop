class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers
    #this needs to be limited to 5 customers
    customers = joins(invoices: :transactions)
                .where(transactions: {result: 'success'})
                .limit(5)
                .group("(first_name || ' ' || last_name)")
                .count
    result = customers.sort_by { |name, count| count }.reverse
  end
end
