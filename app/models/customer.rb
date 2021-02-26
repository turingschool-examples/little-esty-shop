class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers
    Transaction.joins(invoice: :customer).where("result = 'success'").group("customers.id").select("customers.id, customers.first_name, customers.last_name, COUNT(customers.*) AS count_of_success").order(count_of_success: :desc).limit(5)
  end
end
