class Merchant < ApplicationRecord

  has_many(:items)
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: {"disabled" => 0, "enabled" => 1}

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
  end

end
