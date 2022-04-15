class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_5_customers
    customers.joins(invoices: :transactions)
      .select("customers.*, count(transactions) as successful_transactions")
      .where("transactions.result = ?", "success")
      .group(:id)
      .order("successful_transactions desc")
      .limit(5)
  end

  def top_five_items
    Item.joins(invoices: :transactions)
      .where(invoices: {status: 1}, transactions: {result: "success"})
      .select("items.id, items.name, sum(invoice_items.quantity * invoice_items.unit_price) as total_rev")
      .group(:id)
      .order("total_rev desc")
      .limit(5)
  end

  def items_ready_to_ship
    invoices.select("items.name, invoices.id, items.id as item_id, invoices.created_at")
      .where("invoice_items.status != 2")
      .order("invoices.created_at ASC")
  end
end
