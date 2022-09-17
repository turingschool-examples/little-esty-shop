class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def distinct_invoices
    invoices.distinct
  end

  def top_five_customers
    customers
      .joins(:transactions)
      .select(customers.*)
      .where('transactions.result = 0')
      .count('transactions.id')
      .group(:customer_id)
      .order('count_transactions_id desc')
  end

end
