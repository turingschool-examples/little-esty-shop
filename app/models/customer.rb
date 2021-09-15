class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def self.top_five
    Customer.joins(invoices: :transactions)
            .select('COUNT(transactions.result) as successful, customers.id, customers.first_name as f_name, customers.last_name as l_name')
            .group('customers.id')
            .where('transactions.result = ?', 0)
            .order(successful: :desc, f_name: :asc, l_name: :asc)
            .limit(5)
  end
end
