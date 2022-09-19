class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name
  validates :enabled, inclusion: { in: [ true, false ] }


  def ready_to_ship
    items.select("items.*, invoice_items.status as not_shipped, invoices.created_at as created_at").joins( invoices: :invoice_items).where.not("invoice_items.status = ?", 2)
  end

  def self.top_5_revenue
   select('merchants.name, sum(invoice_items.quantity * invoice_items.unit_price) as revenue').joins(:invoice_items).group(:id).order('revenue desc').limit(5)
  end

  def favorite_customers
    Customer.select("customers.*, count(transactions) as transaction_count").joins(invoices: :transactions).where(transactions: {result: 1}).group(:id).order(transaction_count: :desc).limit(5)
  end

  def top_5_items
    items
    .joins(:invoice_items, invoices: :transactions)
    .where(transactions: {result: 1})
    .select('items.id, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group('items.id')
    .order('revenue desc')
    .limit(5)
  end
end
# Merchant Items Index: 5 most popular items

# As a merchant
# When I visit my items index page
# Then I see the names of the top 5 most popular items ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name

# Notes on Revenue Calculation:

# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)