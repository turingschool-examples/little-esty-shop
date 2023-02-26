class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, -> { distinct }, through: :invoices  
  has_many :transactions, -> { distinct }, through: :invoices

  def rank_by_revenue
    # items.joins(:invoices, :transactions).where(transactions: {result: "success"}).select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").group(:id)
    x = Item.joins(invoices: :transactions).where(invoices: {status: 1}, transactions: {result: 0}).select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").group(:id).order(revenue: :desc)
    require 'pry'; binding.pry
  end
end
