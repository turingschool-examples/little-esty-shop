class Customer < ApplicationRecord
  has_many :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true


  def self.top_customers_for_merchant(merchant_id)
    select("customers.*, COUNT(transactions.id) AS transaction_count")
      .joins("INNER JOIN invoices ON customers.id = invoices.customer_id")
      .joins("INNER JOIN transactions ON invoices.id = transactions.invoice_id")
      .joins("INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id")
      .joins("INNER JOIN items ON invoice_items.item_id = items.id")
      .joins("INNER JOIN merchants ON items.merchant_id = merchants.id")
      .where("transactions.result = 0")
      .where("merchants.id = ?", merchant_id)
      .group(:id)
      .order("transaction_count DESC")
      .limit(5)
  end

end
