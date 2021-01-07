class Customer < ApplicationRecord
  has_many :invoices

  def self.favorite_customers
    select("customers.*, count(*) AS count").joins("JOIN transactions ON transactions.invoice_id = invoices.id").where(transactions: {result: 0}).group(:id).order("count DESC").limit(5)
  end
end
