class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def most_popular_items
    items.joins(:invoice_items, :invoices, :transactions)
         .select('items.*, invoice_items.quantity * invoice_items.unit_price AS total_revenue')
         .distinct
         .where("transactions.result = 'success'")
         .order("total_revenue desc")
         .limit(5)
  end
end
