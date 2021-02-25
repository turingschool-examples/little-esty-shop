class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def self.top_customers
    # gotta edit this to work (it's from Jake and Megan)
    Customer.joins(invoices: :transactions)
            .where('customer_id = ?', customer.id)
            .where('result = ?', "success")
            .select("customers.*, count('transactions.result') as successful_transactions")
            .group('customers.id')
            .order(successful_transactions: :desc)
            .limit(5)
  end
end
