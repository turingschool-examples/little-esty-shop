class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

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

  def top_five_items
    items.joins(invoices: :transactions)
         .where("transactions.result = 'success'")
         .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
         .group(:id)
         .order('revenue desc')
         .limit(5)
  end 
end
