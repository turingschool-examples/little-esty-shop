class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices


  def top_five_customers
    successes = invoices.where(id: transactions.where(result: 'success').pluck(:invoice_id))
    x = successes.group(:customer_id).count
    x = x.sort_by { |k,v| 0 - v }.map { |a| a[0] }
    Customer.find(x)[0..4]

    # require 'pry'; binding.pry
    # Customer.find(invoices.pluck(:customer_id))
    # Customer.select('customers.*, invoices.*').joins(:invoices).where('invoices.id = ?', successes.pluck(:id))
    # x = successes.group(:customer_id).count
  end
end