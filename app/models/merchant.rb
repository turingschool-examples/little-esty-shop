class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items, dependent: :destroy

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

   def top_admin_5_customers
     Customer.select('customers.*, count(transactions.result) as revenue')
     .joins(invoices: :transactions)
     .group(:id)
     .where('transactions.result = ?', 'success')
     .order(revenue: :desc)

   end

  def top_5_customers
    joins(:items)
    .joins("RIGHT JOIN invoice_items ON items.id = invoice_items.item_id")
    .joins("RIGHT JOIN invoices ON invoices.id = invoice_items.invoice_id")
    .joins("RIGHT JOIN customers ON customers.id = invoices.customer_id")
    .joins("LEFT JOIN transactions ON invoices.id = transactions.invoice_id")
    .where(id: params[:merchant_id])
    .where("transactions.result = 'success'")
    .group("transactions.result, customers.id")
    .order("transactions_per DESC")
    .select("DISTINCT customers.*, count(transactions.result = 'success') as transactions_per")
    .limit(5)
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
