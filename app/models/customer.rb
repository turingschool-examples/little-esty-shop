class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :created_at
  validates_presence_of :updated_at

  has_many :invoices 

  def self.top_five_customers
      # joins(invoices: :transactions).where(transactions: { result: 'success' }).group('id').order('COUNT(*) DESC').limit(5)
      select('COUNT(*) AS total_transactions, customers.*').joins(invoices: :transactions).where(transactions: { result: 'success' }).group('customers.id').order('total_transactions desc').limit(5)
  end 
end
