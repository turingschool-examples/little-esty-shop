class Merchant < ApplicationRecord
  has_many :items
  
  def not_shipped
    items.select("items.*, invoice_items.status as not_shipped").joins(:invoice_items).where.not("invoice_items.status = ?", 2)
  end 
    
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

  def top_five_cust_by_transaction
    items.joins( invoices: [:transactions, :customer])
    .where("transactions.result = 0")
    .select("customers.*, count(transactions.id) as transaction_count")
    .group("customers.id")
    .order(transaction_count: :desc)
    .limit(5)
  end
end 
