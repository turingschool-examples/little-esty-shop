class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.top5(id)
    Customer
    .joins(:merchants, :transactions)
    .where("transactions.result = 1 AND merchants.id = #{id}")
    .group(:id)
    .select('first_name, last_name, count(customers) AS transactions_count')
    .order(transactions_count: :desc)
    .limit(5)
  end

  def pending_invoices
    Invoice
    .joins(:merchants)
    .where("merchants.id = #{id}")
    .where('invoices.status = 1')
    .distinct
  end
end
