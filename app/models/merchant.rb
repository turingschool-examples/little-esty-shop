class Merchant < ApplicationRecord
  has_many(:items)
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def favorite_customers
    transactions
    .joins(invoice: :customer)
    .where(transactions: {result: :success})
    .select('customers.*')
  end

  def items_ready_to_ship
    invoice_items
    .order(created_at: :asc)
    .where.not(status: 'shipped')
    # item_id = InvoiceItem.where.not(status: 'shipped').order(created_at: :asc).pluck(:item_id)
    # items.where(id: item_id)
  end
end
