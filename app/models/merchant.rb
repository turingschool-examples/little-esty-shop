class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name


  enum status: [:enabled, :disabled]

  def enabled!
    update(status: :enabled)
  end
  
  def disabled!
    update(status: :disabled)
  end
  
  def self.top_five_merch_by_revenue
    Merchant.select("merchants.name, merchants.id, 
      sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: :success})
    .group(:id)
    .order("total_revenue DESC")
    .limit(5)
  end
  
  def total_merch_revenue
    self.invoices
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: :success})
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def top_selling_date
    self.invoices
    .select("invoices.created_at, invoices.id, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .joins(:transactions, :invoice_items)
    .where(transactions: {result: :success})
    .group(:id)
    .order("total_revenue DESC")
    .limit(1)
    .first
    .created_at
    .strftime("%A, %B %d, %Y")
  end
end

