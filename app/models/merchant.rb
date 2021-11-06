class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name

  def merchant_invoices
    invoices
  end

  def favorite_customers
    customers.joins(invoices: :transactions)
             .where('transactions.result = ?', 'success')
             .group('customers.id')
             .select('customers.*')
             .order(count: :desc)
             .limit(5)
             .count
  end

  def self.merchant_status(status)
    where(status: status)
  end
end
