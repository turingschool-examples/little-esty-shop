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


  def self.enabled_merchants
    Merchant.all.select{|merchant| merchant.status == 'Enabled'}
    # Merchant.all.where(status: 'Enabled')
  end

  def self.disabled_merchants
    Merchant.all.select{|merchant| merchant.status == 'Disabled'}
  end
end
