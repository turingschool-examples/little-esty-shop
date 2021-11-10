class Customer < ApplicationRecord
  has_many :invoices

  def self.top_customers
    customers = joins(invoices: :transactions)
                .where(transactions: {result: 'success'})
                .limit(5)
                .group("(first_name || ' ' || last_name)")
                .count
    result = customers.sort_by { |name, count| count }.reverse
  end
#there must be a simpler way to do this but it's too late in the day
  def self.find_by_invoice_id(invoice_id)
    invoice = Invoice.find(invoice_id)
    id = invoice.customer_id
    Customer.find(id)
  end
end
