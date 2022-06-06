class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name, :status

  def items_ready_to_ship
    merchant_items = Item.where("merchant_id = #{self.id}")
    InvoiceItem.where(item_id: merchant_items).where(status: [0,1]).order(:created_at)
  end

  def top_5_customers
    #Find items associated with the curent merchant
    merchant_items = Item.where(merchant_id: id)  ##works in heroku
    #Find the invoices associated with these items
    merchant_invoices = Invoice.joins(:items).where(items: { id: merchant_items })  ##works
    #Find only the invoices that had successful transactions
    successful_invoices = Invoice.joins(:transactions).where(id: merchant_invoices).where(transactions: { result: "success" })
    #Group the invoices by customer_id and count how many invoices there are for each customer, order them from most invoices to least
    invoice_customer_count_sorted = Invoice.where(id: successful_invoices).select("invoices.customer_id, count(customer_id)").group(:customer_id).order(count: :desc)
    #Select the first 5 customers from the invoices
    cust_ids = invoice_customer_count_sorted.limit(5).pluck(:customer_id)
    #Return an array of the top 5 customers
    customers_top_5 = Customer.find(cust_ids)
  end

  def self.top_5_merchants_by_revenue
    joins(invoices: :transactions)
          .where(transactions: {result: 'success'})
          .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
          .group(:id)
          .order(total_revenue: :desc)
          .limit(5)
  end
  
  def best_day
    best_day_revenue = invoices.group("DATE(invoices.created_at)").sum("invoice_items.quantity * invoice_items.unit_price").sort_by { |day, revenue| revenue }.last
    best_day_revenue[0]
  end

  def top_5_items
    top_5_items = self.items.joins(invoice_items: [:invoice]).where(invoices: {status: 2}).select("items.*, sum(invoice_items.quantity * invoice_items.unit_price)").group(:id).order(sum: :desc).limit(5).to_a
  end

end
