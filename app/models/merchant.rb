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
  end

  def shippable_items
    ActiveRecord::Base.connection.exec_query(
                         "SELECT items.name, invoice_items.id, invoice_items.created_at
                          FROM items
                          INNER JOIN invoice_items ON items.id = invoice_items.item_id
                          INNER JOIN merchants ON merchants.id = items.merchant_id
                          WHERE invoice_items.status = '0' AND merchants.id = '#{self.id}'
                          ORDER BY invoice_items.created_at"
                        ).rows
  end

  def invoice_ids
    items.joins(:invoices).distinct.pluck(:invoice_id)
  end
end
