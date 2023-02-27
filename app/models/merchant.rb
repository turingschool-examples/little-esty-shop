class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, -> { distinct }, through: :invoices  
  has_many :transactions, -> { distinct }, through: :invoices

  def top_five_items_by_revenue
        Item.joins(invoice_items: [invoice: :transactions])
          .where('invoices.status = 1 AND transactions.result = 0')
          .group('items.id')
          .select('items.*, SUM(DISTINCT invoice_items.quantity * invoice_items.unit_price) as revenue')
          .order('revenue DESC')
          .limit(5)
  end
end
