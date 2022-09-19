class Merchant < ApplicationRecord
  has_many :items

  def enabled_items
    items.where(enabled: true)
  end

  def disabled_items
    items.where(enabled: false)
  end

  def top_items
    id = self.id
    Item.joins(invoices: :transactions)
    .where(["transactions.result = ? and items.merchant_id = ?", 0, id])
    .select(:name, :id, "sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end

  def self.enabled_merchants
    Merchant.all.select{|merchant| merchant.status == 'Enabled'}
  end

  def self.disabled_merchants
    Merchant.all.select{|merchant| merchant.status == 'Disabled'}
  end

  def self.top_5_merchants

    Merchant.joins(items: {invoices: :transactions})
    .where("transactions.result = 0")
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
    #get quantity and unit_price from invoice_item, status from transaction,
  end

  def highest_sales_date
    items.select(:created_at, "invoice_items.unit_price * invoice_items.quantity as revenue").order("revenue desc").first.created_at

  end
end
