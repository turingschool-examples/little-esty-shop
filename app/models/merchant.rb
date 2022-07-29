class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_5_customers
    customers
    .joins(:transactions)
    .group("customers.id")
    .where(transactions: {result: "success"}, invoices: {status: "completed"})
    .select("customers.*, count(transactions.id) as no_of_transactions")
    .order("no_of_transactions desc").limit(5)
  end

  def ready_to_ship
    Item.joins(:invoices)
    .select("items.name, invoice_items.id as inv_item, invoices.id as inv_id, invoices.created_at as invoice_date")
    .where(invoice_items: {status: :packaged }, items: {merchant_id: id})
    .order("invoices.created_at")
  end
end
