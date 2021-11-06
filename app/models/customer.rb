class Customer < ApplicationRecord
  has_many :invoices

  def successful_transactions(merchant_id)
    Transaction.joins(invoice: [:customer])
    .where(result: 'success')
    .where(customers: { id: id })
    .joins(invoice: [invoice_items: [item: [:merchant]]])
    .where(merchants: { id: merchant_id })
    .count
  end

  def self.top_customers
    customers = joins(invoices: :transactions)
                .where(transactions: {result: 'success'})
                .limit(5)
                .group("(first_name || ' ' || last_name)")
                .count
    result = customers.sort_by { |name, count| count }.reverse
  end
end
