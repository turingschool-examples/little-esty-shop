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
    .order('invoices.created_at')
    .distinct
  end

  def self.total_revenue(invoice_id)
    Invoice 
    .joins(:invoice_items)
    .where("invoice_items.invoice_id = #{invoice_id}")
    .sum('invoice_items.quantity * invoice_items.unit_price')
    
  end

  def self.enabled 
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end
end
