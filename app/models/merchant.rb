class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  enum status: {
    enabled: 0,
    disabled: 1
   }

   def self.enabled_list
     where(status: 0)
   end

   def self.disabled_list
     where(status: 1)
   end

  def top_5_customers
    Merchant.joins(:items)
    .joins("RIGHT JOIN invoice_items ON items.id = invoice_items.item_id")
    .joins("RIGHT JOIN invoices ON invoices.id = invoice_items.invoice_id")
    .joins("RIGHT JOIN customers ON customers.id = invoices.customer_id")
    .joins("LEFT JOIN transactions ON invoices.id = transactions.invoice_id")
    .where(id: self.id)
    .where("transactions.result = 'success'")
    .group("transactions.result, customers.id")
    .order("transactions_per DESC")
    .select("DISTINCT customers.*, count(transactions) as transactions_per")
    .limit(5)
  end


  def items_ready_to_ship
    Item.joins(invoices: :invoice_items)
    .where("items.merchant_id = ?", self.id)
    .where(invoice_items: {status: 0})
    .select("items.*, invoices.id AS invoice_id, invoices.created_at as invoice_created_at")
    .order('invoice_created_at')
  end


  def self.top_5_merchants
    joins(items: {invoice_items: {invoice: :transactions}})
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .where("transactions.result = ?", "success")
    .group("merchants.id")
    .order(revenue: :desc)
    .limit(5)
  end

  def merchant_best_day_ever
    Merchant.joins(items: {invoice_items: :invoice})
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue, invoices.created_at AS date_created")
    .where("merchants.id = ?", id)
    .group(:id, :date_created)
    .order(revenue: :desc, date_created: :desc)
    .limit(1)
    .first
    .date_created
    .strftime("%m/%d/%y")
  end
end
