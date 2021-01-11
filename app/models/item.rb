class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  scope :enabled, -> {where(enabled: true)}
  scope :disabled, -> {where(enabled: false)}

  delegate :top_sales_day, to: :invoices

  def self.items_to_ship
    joins(:invoices).select("items.*, invoice_id, invoices.created_at AS invoice_created").where(invoice_items: {status: 1}).order("invoice_created")
  end

  def self.popular_items
    select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue").joins(invoices: :transactions).where("transactions.result = 0").group(:id).order(total_revenue: :desc).limit(5)
  end

  # def top_sales_day
  #   require "pry"; binding.pry
  #   invoices.joins(:transactions).where(transactions: {result: 0}).select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price)").group(:created_at).order(sum: :desc).first.created_at
  # end
end
