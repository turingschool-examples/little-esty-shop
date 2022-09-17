class Merchant < ApplicationRecord
  validates_presence_of :name
  enum status: { Enabled: 0, Disabled: 1}

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.top_five_merchants
    self.joins(:transactions)
    .where(invoices: {status: 2}, transactions: {result: 'success'})
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group(:id)
    .order("revenue desc")
    .limit(5)
  end
end
