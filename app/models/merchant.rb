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
  
  def items_ready_to_ship
    Merchant.joins(invoice_items: [invoice: :transactions]).
    where(merchants: {id: self.id}, invoice_items: {status: [0,2]}, invoices: {status: [1,2]}, transactions: {result: true}).
    select("items.name, invoices.id, invoices.created_at").
    order("invoices.created_at ASC")
  end
end
