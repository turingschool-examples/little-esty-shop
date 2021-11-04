class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


  def top_5
    Items.select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").group(:id).order('revenue desc').limit(5)
    # group(:id).all(&:revenue).order('revenue desc').limit(5)
  end
end
