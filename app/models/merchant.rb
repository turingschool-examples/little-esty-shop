class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def top_five_customers
    Customer.select('customers.*, COUNT(transactions.id) as transaction_count')
           .joins(invoices: [:transactions, :invoice_items => :item])
           .where("items.merchant_id = ? AND transactions.result = ?", self.id, 1)
           .group('customers.id')
           .order('transaction_count DESC')
           .limit(5)
  end
end