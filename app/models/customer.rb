class Customer < ApplicationRecord
  has_many :invoices

  def name
    "#{first_name} #{last_name}"
  end

  def self.top_five_cust
    Customer.joins(invoices: [:transactions])
            .select('customers.*, count(transactions.id) as transaction_count')
            .where('transactions.result = 0')
            .group(:id)
            .order('transaction_count desc')
            .limit(5)
  end

  
end
