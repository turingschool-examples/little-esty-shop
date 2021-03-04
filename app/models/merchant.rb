class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: [ :enabled, :disabled ]

  def top_five_customers
    transactions
    .joins(invoice: :customer)
    .where('result = ?', true)
    .select("customers.*, count('transactions.result') as purchases")
    .group('customers.id')
    .order(purchases: :desc)
    .limit(5)
  end

  def items_not_shipped
    invoice_items
    .where.not("invoice_items.status = ?", "shipped")
    .joins(:invoice)
    .order("invoices.created_at")
  end

  def top_five_items
    items
    .joins(invoices: :transactions)
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .where('transactions.result = true')
    .group(:id)
    .order('total_revenue desc')
    .limit(5)
  end

  def total_revenue
    invoice_items.sum(:unit_price)
  end


#    items
#    .joins(invoices: :transactions)
#    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
#    .where('transactions.result = true')
#    .group('items.id')
#    .order('total_revenue desc')
#    .limit(5)
#   end


  def self.merchant_invoices(merchant_id)
    find(merchant_id)
    .invoices
    .distinct
  end

  def self.top_five_merchants
    joins(invoices: [:transactions, :invoice_items])
    .where("transactions.result = true")
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as merchant_revenue")
    .group(:id)
    .order(merchant_revenue: :desc)
    .limit(5)
  end

  def top_day
    invoices.joins(:transactions)
    .where("transactions.result = true")
    .select("invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) as merchant_revenue")
    .group(:id)
    .order(merchant_revenue: :desc)
    .first
    .created_at
  end
end
