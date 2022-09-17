class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  def distinct_invoices
    invoices.distinct
  end

  def top_five_customers
    customers
      .joins(:transactions)
      .select('count(transactions.id), customers.*')
      .where('transactions.result = 1')
      .order('count desc')
      .group('customers.id')
      .limit(5)
  end

end
