class Merchant < ApplicationRecord
  has_many(:items)
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def favorite_customers
    customers
    .joins(invoices: :transactions)
    .where('transactions.result = ?', 'success')
    .group('customers.id')
    .order('transactions.count DESC')
    .limit(5)
  end

  def items_ready_to_ship
    invoice_items
    .order(created_at: :asc)
    .where.not(status: 'shipped')
  end

end
