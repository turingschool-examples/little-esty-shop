class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, -> { distinct }, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  
  enum status: [ :disabled, :enabled ]


  def unshipped
    items.joins(invoice_items: :invoice)
    .select('invoices.id as invoice_id, invoices.created_at as invoice_created, name')
    .where.not('invoice_items.status = ?', 2)
    .distinct
    .order('invoices.created_at DESC')
  end

  def items_by_status_true
    items.where(status: true)
  end

  def items_by_status_false
    items.where(status: false)
  end

  def top_5_items_by_revenue
    items.joins(invoices: :transactions)
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .where("transactions.result = ?", 0)
    .group("items.id")
    .order(revenue: :desc).limit(5)
  end

  def top_five_customers
    customers.joins(invoices: :transactions).where('transactions.result = ?', 0)
            .select('customers.*, count(invoices) as successful')
            .group(:id).order(successful: :desc)
            .limit(5)
  end

  def total_revenue
    invoice_items.joins(invoice: :transactions)
    .where('transactions.result = ?', 0)
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def best_day
    invoices.joins(:transactions)
    .where('transactions.result = ?', 0)
    .select('invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .group(:id)
    .order(revenue: :desc)
    .reorder(created_at: :desc)
    .first
    .created_at
  end
  
  def self.top_five_by_revenue
    joins(invoices: :transactions)
    .where('transactions.result = ?', 0)
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
    .group(:id)
    .order(total_revenue: :desc)
    .limit(5)
  end
end
