class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, -> { distinct }, through: :invoice_items
  has_many :transactions, -> { distinct }, through: :invoices
  has_many :customers, -> { distinct }, through: :invoices

  validates :name, presence: true

  def self.all_enabled
    where(is_enabled: true).order(:name)
  end

  def self.all_disabled
    where(is_enabled: false).order(:name)
  end

  def self.find_top_5
    joins(items: { invoice_items: { invoice: :transactions }})
    .where(transactions: { result: "success" })
    .group('merchants.id')
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .order('revenue DESC')
    .limit(5)
  end

  def enabled_status
    if is_enabled?
      "Enabled"
    else
      "Disabled"
    end
  end

  def highest_revenue_date
    invoices.find_with_successful_transactions
      .joins(:invoice_items)
      .select("invoices.id, invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) as total_rev")
      .group(:id)
      .order("total_rev DESC, created_at DESC").first.created_at
  end

  def top_five_customers
    customers.joins(:transactions).where(transactions: {result: 'success'}).select("customers.*, CONCAT(first_name,' ',last_name) as name, count(DISTINCT transactions.id) as transactions_count").group("customers.id").order("transactions_count desc").limit(5)
  end

  def items_not_shipped
    invoice_items.select('invoice_items.*').where(status: [0, 1]).joins(:invoice).order('invoices.created_at')
  end

  def enabled_items
    items.where(is_enabled: true)
  end

  def disabled_items
    items.where(is_enabled: false)
  end

  def top_five_items_by_revenue
    items.joins(:transactions).select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue").where(transactions: {result: "success"}).group("items.id").order(revenue: :desc).limit(5)
  end
end
