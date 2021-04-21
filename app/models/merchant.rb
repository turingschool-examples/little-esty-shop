class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  enum status: [:disabled, :enabled]

  def most_popular_items
    joins(:items).
    select("merchants.name, max(unit_price) as max_unit_price").
    group(:id)
    #I need to add a limit of 5 somewhere
  end


  def self.disabled_merchants
    where(status: "disabled")
  end

  def self.enabled_merchants
    where(status: "enabled")
  end

  def self.top_merchants_revenue
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order(total_revenue: :desc)
    .limit(5)
  end

  def top_five_customers
    self.customers.
    joins(:transactions).
    where("'transactions.result != ?', 'failed' as result").
    select("customers.*, count('result') as top_five").
    group(:id).
    order(top_five: :desc).
    limit(5)
  end

end
