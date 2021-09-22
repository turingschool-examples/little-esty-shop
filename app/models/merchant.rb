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

  def items_disabled_list 
    Item.select("items.*")
    .where(items: {status: 1})
    .where("merchant_id = ?", self.id)
  end

  def items_enabled_list 
    Item.select("items.*")
    .where(items: {status: 0})
    .where("merchant_id = ?", self.id)
  end

   # def self.top_admin_5_customers
   #   Customer.select('customers.*, count(transactions.result) as revenue')
   #   .joins(invoices: :transactions)
   #   .group(:id)
   #   .where('transactions.result = ?', 'success')
   #   .order(revenue: :desc)
   #   .limit(5)
   #
   # end
 

  def top_5_customers
    Customer.select("DISTINCT customers.*, count(transactions) as transactions_per")
    .joins(invoices: :transactions)
    .where("invoices.id IN (?)", 
    Invoice.joins(:items)
    .where("items.merchant_id = ?", self.id)
    .pluck("invoices.id").uniq
  )
    .merge(Transaction.transaction_successful?)
    .group("customers.id")
    .order("transactions_per DESC")
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
