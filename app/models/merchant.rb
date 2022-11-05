class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices

  def self.all_enabled
    where(status: 'Enabled')
  end

  def self.all_disabled
    where(status: 'Disabled')
  end

  def top_five_customers
    Customer.select('customers.*, count(transactions.*) as num_transactions').joins(invoices: [:transactions, :items]).where("transactions.result = 0").where("items.merchant_id = ?", self.id).order('num_transactions desc').group(:id).limit(5)
  end

  def incomplete_invoices
    invoices.where(status: 1).distinct.order(:created_at)
  end

  def enabled_items
    items.where("status= ?", "Enabled")
  end

  def disabled_items
    items.where("status= ?", "Disabled")
  end
  
  def most_popular_items
    Item.select('items.*, sum(invoice_items.quantity* invoice_items.unit_price) as revenue').joins(:invoice_items, :transactions).where("transactions.result = 0").where("items.merchant_id = ?", self.id).order('revenue desc').group(:id).limit(5)
  end

  def item_revenue 
    # Item.select('items.*, sum(invoice_items.quantity* invoice_items.unit_price) as revenue').joins(:invoice_items, :transactions).where("transactions.result = 0").where("items.merchant_id = ?", self.id)
    # Item.select('items.*, sum(invoice_items.quantity* invoice_items.unit_price) as revenue').joins(:invoice_items, :transactions).where('transactions.result = 0').group(:id)
    Item.select('sum(invoice_items.quantity* invoice_items.unit_price) as revenue').joins(:invoice_items, :transactions).where("transactions.result = 0").where("items.merchant_id = ?", self.id).group(:id)
  end

end