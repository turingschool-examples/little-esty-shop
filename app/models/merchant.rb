class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: {"enabled": 0, "disabled": 1}

  def favorite_customers
    customers
    .joins(:transactions)
    .where('transactions.result = ?', 'success')
    .group('customers.id')
    .select('customers.*, count(*) as transaction_count')
    .order('transaction_count desc')
    .limit(5)
  end

  def ready_to_ship
    invoice_items
    .joins(:invoice)
    .where.not("invoice_items.status = ?", 2)
    .order("invoices.created_at")
  end

  def five_most_popular_items
    items
    .joins(:invoice_items, :transactions)
    .where('transactions.result = ?', 'success')
    .group('items.id')
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .order('revenue desc')
    .limit(5)
  end
end
