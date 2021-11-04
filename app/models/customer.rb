class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers
    customers = joins(invoices: :transactions).where(transactions: {result: 'success'})
    first_name_hash = customers.group(:first_name).count
    customer_hash = Hash.new
    first_name_hash.each do |k, v|
      customer_hash[Customer.find_by(first_name: k)] = v
    end
    result = customer_hash.sort_by { |name, age| age }.reverse
  end
end
