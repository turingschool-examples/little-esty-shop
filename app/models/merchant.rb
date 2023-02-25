class Merchant < ApplicationRecord
  validates :name, presence: true
  
  enum status: ["Enabled", "Disabled"]
  
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five_merchant_customers
    self.customers
      .joins(invoices: :transactions)
      .select("customers.*, count('transactions.id') as total_purchases")
      .where(transactions: {result: 0})
      .group(:id)
      .order(count: :desc)
      .limit(5)
  end

  def invoice_items_ready_to_ship
    self.invoice_items
    .joins(:invoice)
    .where(status: "packaged")
    .order(created_at: :asc)
  end

  def self.enabled_merchants
    self.where(status: "Enabled")
  end
  
  def self.disabled_merchants
    self.where(status: "Disabled")
  end
end
