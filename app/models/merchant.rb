class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers,-> {distinct}, through: :invoices

  validates :name, presence: true

  delegate :favorite_customers, to: :customers
  delegate :items_to_ship, to: :items

  def total_revenue
    invoices.joins(:transactions, :invoice_items)
    .where("result = 0")
    .select('quantity, unit_price')
    .sum("quantity * unit_price")
  end

  def best_day
    invoices.joins(:transactions, :invoice_items)
    .where("result = 0")
    .select("CAST (invoices.created_at AS DATE) as created_date, sum(quantity * unit_price) as revenue")
    .group("created_date")
    .order("revenue" => :desc)
    .limit(1)
    .first.created_date #return the date specifically
  end

  def self.top_merchants(number)
    Merchant.joins(invoices: [:transactions, :invoice_items])
    .where("result = 0")
    .group(:id)
    .select('merchants.*, sum(quantity * unit_price) as total_revenue')
    .order("total_revenue" => :desc)
    .limit(number)
  end
end
