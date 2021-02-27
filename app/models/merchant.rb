class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customer
    transactions
    .joins(invoice: :customer)
    .where('result = ?', true)
    .select("customers.*, count('transactions.result') as top_result")
    .group('customers.id')
    .order(top_result: :desc)
    .limit(5)
  end
end
