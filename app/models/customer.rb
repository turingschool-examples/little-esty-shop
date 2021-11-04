class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers
    customers = joins(invoices: :transactions).where(transactions: {result: 'success'})
    hash = customers.group("(first_name || ' ' || last_name)").count
    result = hash.sort_by { |name, count| count }.reverse
  end
end
