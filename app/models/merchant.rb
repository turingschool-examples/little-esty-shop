class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five_customers
    require "pry"; binding.pry
    Transaction.joins(invoices: :customers).where('transactions.result == ?', "success").where('transactions.merchant_id == self.id')
    # self.transactions.joins(invoices: :customers).where('transactions.result == ?', "success").group('customer.id')
# - from merchant, joins to invoices,transactions, customers
# - only complete invoice records
# -
# - group by customer_id
# - select customer.name
# - count, records: as completed_invoices
# - order by completed_invoices desc
# - limit 5
# self.transactions.joins(invoices: :customers)
  end
  # SELECT * FROM merchants INNER JOIN invoices ON invoices.merchant_id = merchants.id INNER JOIN transactions ON transactions.invoice_id = invoices.id INNER JOIN invoices invoices_merchants ON invoices_merchants.merchant_id = merchants.id INNER JOIN invoices invoices_merchants_join ON invoices_merchants_join.merchant_id = merchants.id INNER JOIN customers ON customers.id = invoices_merchants_join.customer_id
  # SELECT * FROM merchants INNER JOIN invoices ON invoices.merchant_id = merchants.id INNER JOIN transactions ON transactions.invoice_id = invoices.id;
  # SELECT * FROM merchants INNER JOIN invoices ON invoices.merchant_id = merchants.id INNER JOIN transactions ON transactions.invoice_id = invoices.id INNER JOIN invoices invoices_merchants ON invoices_merchants.merchant_id = merchants.id;
  # SELECT * FROM merchants INNER JOIN invoices ON invoices.merchant_id = merchants.id INNER JOIN transactions ON transactions.invoice_id = invoices.id INNER JOIN invoices invoices_merchants_join ON invoices_merchants_join.merchant_id = merchants.id INNER JOIN customers ON customers.id = invoices_merchants_join.customer_id INNER JOIN invoices invoices_customers ON invoices_customers.customer_id = customers.id;
  # SELECT * FROM merchants INNER JOIN invoices ON invoices.merchant_id = merchants.id INNER JOIN transactions ON transactions.invoice_id = invoices.id INNER JOIN invoices invoices_merchants_join ON invoices_merchants_join.merchant_id = merchants.id INNER JOIN customers ON customers.id = invoices_merchants_join.customer_id INNER JOIN invoices invoices_customers ON invoices_customers.customer_id = customers.id WHERE (transactions.result == TRUE);

end
