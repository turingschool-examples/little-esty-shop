class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
    transactions.joins(invoice: :customer).select("customers.*, COUNT(transactions) AS count_of_success, customers.id AS customer_id").where("transactions.result = ?", 'success').group("customers.id").order("count_of_success DESC").limit(5)
  end

  def self.enabled_merchants
    where("status = 'enabled'").order(name: :asc)
  end

  def self.disabled_merchants
    where("status = 'disabled'").order(name: :asc)
  end

  def items_ready_to_ship
      items.joins(:invoice_items).joins(:invoices).select("items.name, invoice_items.invoice_id, invoice_items.status, invoices.created_at AS ICA").where.not("invoice_items.status = ?",  '2').order("ICA ASC")
  end

  # def self.top_five_merchants
  #   InvoiceItem.joins("JOIN invoices ON invoice_items.invoice_id = invoices.id JOIN items ON invoice_items.item_id = items.id JOIN transactions ON transactions.invoice_id = invoices.id JOIN merchants ON merchants.id = items.merchant_id").where("transactions.result = 'success' AND invoices.status != 0").group("merchants.id").select("merchants.id, merchants.name , SUM (invoice_items.quantity * invoice_items.unit_price) AS revenue").order("revenue DESC").limit(5)
  # end

  def self.top_five_merchants
    InvoiceItem.joins("JOIN invoices ON invoice_items.invoice_id = invoices.id JOIN items ON invoice_items.item_id = items.id JOIN transactions ON transactions.invoice_id = invoices.id JOIN merchants ON merchants.id = items.merchant_id").where("transactions.result = 'success' AND invoices.status != 0").group("merchants.id").select("merchants.id, merchants.name , SUM (invoice_items.quantity * invoice_items.unit_price) AS revenue").order("revenue DESC").limit(5)
  end
  
  def top_five_items
    items.joins(:invoice_items).joins(invoices: :transactions).select('items.*, Sum(invoice_items.quantity * invoice_items.unit_price) AS Revenue').where("transactions.result = ?", 'success').group("items.id").order("Revenue DESC").limit(5)
  end



end
