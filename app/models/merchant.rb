class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true


  def top_five_items
    items
    .joins(invoice_items: [invoice: :transactions])
    .where(transactions: {result:true})
    .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .order('revenue desc')
    .limit(5)
  end
end
