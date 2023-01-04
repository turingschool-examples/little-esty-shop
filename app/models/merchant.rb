class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def top_five_customers
    customers.joins(invoices: :transactions)
      .where(transactions: { result: "success"})
      .select('customers.*, count(transactions.*) as total_transactions')
      .order(total_transactions: :desc)
      .group('customers.id')
      .limit(5)
  end

  def items_ready_to_ship
    # items.joins(:invoice_items).where.not(status: 2)
    invoice_items.joins(:invoice)
    .where.not(status: 2)
    .order("invoices.created_at")
    # .pluck(:invoice_id)
  end
end