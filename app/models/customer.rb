class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.merchant_top_five(merchant_id)
    joins(:transactions, :merchants)
    .select("customers.*, CONCAT(customers.first_name, ' ', customers.last_name) as full_name, count(transactions.*) as num_of_transactions")
    .where("transactions.result = 0 and items.merchant_id = ?", merchant_id)
    .group(:id)
    .order("num_of_transactions desc")
    .limit(5)
  end
end
