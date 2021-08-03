class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

  def top_five_items
    items.joins(invoices: :transactions)
         .where(transactions: {result: true})
         .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
         .group("items.id")
         .order(revenue: :desc)
         .limit(5)
  end
end
