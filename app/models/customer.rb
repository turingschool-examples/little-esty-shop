class Customer < ApplicationRecord
  has_many :invoices

  # def self.top_customers
  #   @customers = joins(invoices: :transactions).where(transactions: {result: 'success'})
  #   binding.pry
  #   @customers.each do |customer|
  #     customer.invoices.each do |invoice|
  #       invoice.transactions.count
  #     end
  #   end
  #  
end
