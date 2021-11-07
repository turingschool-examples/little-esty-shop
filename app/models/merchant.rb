class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  enum status: { "Disabled" => 0, "Enabled" => 1}

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end
  
  def top_customers
    Customer.select("customers.*, COUNT(transactions.*) AS transaction_count").joins(
                         "INNER JOIN invoices ON invoices.customer_id = customers.id
                          INNER JOIN transactions ON transactions.invoice_id = invoices.id
                          INNER JOIN invoice_items ON invoice_items.invoice_id = transactions.invoice_id
                          INNER JOIN items ON items.id = invoice_items.item_id
                          INNER JOIN merchants ON merchants.id = items.merchant_id")
                          .where("transactions.result = 'success' AND merchants.id = '#{self.id}'")
                          .group(:id)
                          .order(transaction_count: :desc)
                          .limit(5)
  end

  def shippable_items
    items.select("items.*, invoice_items.invoice_id AS invoice_id, invoices.created_at AS invoice_created_at")
         .joins(:invoices)
         .where("invoice_items.status = '0'")
         .order('invoices.created_at')
  end

  def invoice_ids
    items.joins(:invoices).distinct.pluck(:invoice_id)
  end
end
