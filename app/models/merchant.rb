class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices, through: :items

  def distinct_invoices
    invoices.distinct
  end

  def top_five_customers
    Customer
      .joins(invoices: [:transactions, :items])
      .where('transactions.result = 1 AND items.merchant_id = ?', id)
      .select('count(transactions.id) as transaction_count, customers.*')
      .group('customers.id')
      .order('transaction_count desc')
      .limit(5)
  end

end
