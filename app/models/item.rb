class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :unit_price, numericality: { greater_than: 0}

  def self.all_enabled_items
    where(enabled: true)
  end

  def self.all_disabled_items
    where(enabled: false)
  end

  def self.top_five_by_revenue
    joins(invoices: :transactions)
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .where('transactions.result = ?', 0)
    .group(:id)
    .order('total_revenue desc')
    .limit(5)
  end

  def best_sales_day
    invoices
    .joins(:invoice_items)
    .select('invoices.created_at as created_at, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .group('invoices.created_at')
    .max
    .clean_date
  end
end
