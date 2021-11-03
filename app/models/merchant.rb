class Merchant < ApplicationRecord
  has_many :items

  def top_customers
    # item_ids = self.items.pluck(:id)
    # invoice_ids = InvoiceItem.where(item_id: item_ids).distinct.pluck(:invoice_id)
    # transaction_ids = Transaction.where(invoice_id: invoice_ids).pluck(:id)
    # require "pry"; binding.pry
    # customer_ids = Invoice.where(id: invoice_ids).pluck(:customer_id)
    # customers = Customer.where(id: customer_ids)
    # select("customers.*, COUNT(transactions.id)")
    #     .joins("INNER JOIN invoice_items ON items.id = invoice_items.item_id INNER JOIN transactions ON invoice_items.invoice_id = transactions.invoice_id")
    #     .where("transactions.result = 'success'").joins("INNER JOIN invoices ON transactions.invoice_id = invoices.id INNER JOIN customers ON invoices.customer_id = customers.id")
    # #     .group("customers.id")

    result = ActiveRecord::Base.connection.exec_query("SELECT CONCAT(customers.first_name, ' ', customers.last_name) AS name, COUNT(transactions.*) AS transaction_count
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
                          LIMIT 5").rows
  end
end
