class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.top_five_customers
    merchant.customers.joins(invoices: :transactions)
                      .select('customers.id, customers.first_name, customers.last_name, count(transactions) as count')
                      .where('transactions.result =?','success')
                      .order('count desc')
                      .group('customers.id')
                      .limit(5)
  end
end
