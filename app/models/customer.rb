class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

  def self.top_5_customers
    # require "pry"; binding.pry
    joins(invoices: :transactions)
         .where(transactions: {result: true})
         .select('customers.*, count(transactions.id) as num_successful')
         .group(:id)
         .order(num_successful: :desc)
         .limit(5)
  end
end
