class Merchant < ApplicationRecord

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true

  enum status: { disable: 0, enable: 1 }

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end

  def self.new_mechant_id
    all.last.id + 1
  end

  def self.top_merchants_by_revenue
    joins(invoices: [:invoice_items, :transactions])
    .where('result >= ?', 1)
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
    .group(:id)
    .order('total_revenue desc')
    .limit(5)
  end

  def top_popular_items
    require "pry";binding.pry
    items.joins(invoices: [:invoice_items, :transactions])
    .where('transactions.result = ?', 1)
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue_generated")
    .group(:id)
    .order('total_revenue_generated desc')
    .limit(5)
  end

  def merchant_best_day
    invoices
    .joins(:invoice_items)
    .select('invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
    .where(status: 2)
    .group(:created_at)
    .order('total_revenue desc', 'created_at desc')
    .first
    .created_at
    .to_date
    .strftime("%m/%d/%Y")
  end
end
