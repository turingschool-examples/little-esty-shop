class Merchant < ApplicationRecord
  has_many :items

  def top_customers
    ActiveRecord::Base.connection.exec_query(
                         "SELECT CONCAT(customers.first_name, ' ', customers.last_name) AS name, COUNT(transactions.*) AS transaction_count
                          FROM merchants
                          INNER JOIN items ON merchants.id = items.merchant_id
                          INNER JOIN invoice_items ON items.id = invoice_items.item_id
                          INNER JOIN transactions ON invoice_items.invoice_id = transactions.invoice_id
                          INNER JOIN invoices ON transactions.invoice_id = invoices.id
                          INNER JOIN customers ON invoices.customer_id = customers.id
                          WHERE transactions.result = 'success' AND merchants.id = '#{self.id}'
                          GROUP BY customers.id
                          ORDER BY transaction_count
                          DESC
                          LIMIT 5"
                        ).rows
    # Customer.joins(invoices: [:transactions, :items]).joins('INNER JOIN merchants ON merchants.id = items.merchant_id').where("transactions.result = 'success' AND merchants.id = '#{self.id}'").count
    # result = Customer.select('customers.*, COUNT(transactions.*) AS transaction_count').joins(invoices: [:items, :transactions]).where("transactions.result = 'success' AND merchants.id = '#{Merchant.first.id}'").group(:customer_id).order(transaction_count: :desc).limit(5)
  end

  def shippable_items
    items.select("items.*, invoice_items.invoice_id AS invoice_id, invoices.created_at AS invoice_created_at").joins(:invoices).where("invoice_items.status = '0'").order('invoices.created_at')
  end
end
