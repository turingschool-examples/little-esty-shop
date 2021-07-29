class Customer < ApplicationRecord
  has_many :invoices
  validates :first_name, presence: true
  validates :last_name, presence: true


  def self.top_customers_for_merchant(merchant_id)
    find_by_sql("SELECT customers.*,
      COUNT(transactions.id) AS transaction_count FROM customers
      INNER JOIN invoices ON customers.id = invoices.customer_id
      INNER JOIN transactions ON invoices.id = transactions.invoice_id
      INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id
      INNER JOIN items ON invoice_items.item_id = items.id
      INNER JOIN merchants ON items.merchant_id = merchants.id
      WHERE transactions.result = 0 AND merchants.id = #{merchant_id}
      GROUP BY customers.id
      ORDER BY transaction_count DESC LIMIT 5"
    )
  end

end
