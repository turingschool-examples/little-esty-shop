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

  def items_ready_to_ship
      items.joins(:invoice_items).joins(:invoices).select("items.name, invoice_items.invoice_id, invoice_items.status, invoices.created_at AS ICA").where.not("invoice_items.status = ?",  '2').order("ICA ASC")
  end

end
