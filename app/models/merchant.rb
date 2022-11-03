class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def top_merchant_transactions
    Customer
      .select('customers.*, count(transactions) as transactions_count')
      .joins(invoices: [:transactions, { items: :merchant }])
      .where("transactions.result = 0 AND merchants.id = #{id}")
      .group('id')
      .order(transactions_count: :desc)
      .limit(5)
  end
end
