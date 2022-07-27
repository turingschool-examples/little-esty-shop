class Merchant < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :created_at
    validates_presence_of :updated_at

    has_many :items

  def self.top_5_customers
    # customer_ids = customers.joins(:transactions).distinct
    #                        .where(transactions: {result: "success"})
    #                        .group(:id).count(:transactions)
    #                        .sort_by { |id, count| [count, -id] }.reverse
    #                        .first(5)
    #                        .map { |customer_count| customer_count[0] }
    # Customer.find(customer_ids)
    select('COUNT(*) AS total_transactions, customers.*').joins(invoices: :transactions).where(transactions: { result: 'success' }).group('customers.id').order('total_transactions desc').limit(5)

  end
end
