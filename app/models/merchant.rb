class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices


  def top_five_customers
    # # successes = invoices.where(id: transactions.where(result: 'success').pluck(:invoice_id))
    # x = successes.group(:customer_id).count
    # x = x.sort_by { |k,v| 0 - v }.map { |a| a[0] }
    # Customer.find(x)[0..4]

    Customer.select('customers.*, count(transactions.*) as num_transactions').joins(invoices: [:transactions, :items]).where("transactions.result = 0").where("items.merchant_id = ?", self.id).order('num_transactions desc').group(:id).limit(5)
  end

  def incomplete_invoices
    invoices.where(status: 1).distinct
  end
end