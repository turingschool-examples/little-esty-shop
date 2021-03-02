class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
    transactions
    .joins(invoice: :customer)
    .where('result = ?', true)
    .select("customers.*, count('transactions.result') as purchases")
    .group('customers.id')
    .order(purchases: :desc)
    .limit(5)
  end

  def items_not_shipped
    invoice_items
    .where.not("invoice_items.status = ?", "shipped")
    .joins(:invoice)
    .order("invoices.created_at")
  end

  def top_five_items
   items
   .joins(invoices: :transactions)
   .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
   .where('transactions.result = true')
   .group(:id)
   .order('total_revenue desc')
   .limit(5)
 end

 def total_revenue
   invoice_items.sum(:unit_price)
 end

 def self.merchant_invoices(merchant_id)
  find(merchant_id)
  .invoices
 end

end
