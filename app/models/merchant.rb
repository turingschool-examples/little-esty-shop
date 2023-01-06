class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  validates_presence_of :name

  def top_five_customers
    Customer.select("customers.*, count(distinct transactions) as transaction_count")
            .left_joins(:transactions, :items).group(:id)
            .where('transactions.result = ?', 'success')
            .where('items.merchant_id = ?', self.id)
            .order("transaction_count desc").limit(5)
  end

  def ready_to_ship_items
    items.select("distinct items.*, invoices.created_at as invoice_created_at, invoice_items.invoice_id, invoice_items.status")
         .joins(:invoice_items, :invoices)
         .where("invoice_items.status = ?", 1)
         .where("invoice_items.invoice_id = invoices.id")
         .order("invoices.created_at")
  end

  def self.top_5_by_revenue
    Merchant.joins(:transactions)
            .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
            .where('transactions.result = ?', 'success')
            .group(:id)
            .distinct
            .order('total_revenue DESC').limit(5)
  end

  def best_day_by_revenue
    invoices.joins(:transactions)
            .where(transactions: { result: "success" })
            .select('date(invoices.created_at) as invoice_date, sum(invoice_items.unit_price * invoice_items.quantity) as total_date_revenue')
            .group('invoice_date')
            .order('total_date_revenue DESC', 'invoice_date DESC')
            .limit(1)
            .first
            .invoice_date.strftime('%-m/%-d/%Y')
  end

  def revenue_in_dollars
    number_to_currency(total_revenue/100.0)
  end
end