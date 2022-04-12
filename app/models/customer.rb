class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :merchants, through: :items

  def self.top_five
    joins(invoices: :transactions)
    .group('customers.id')
    .order("count(customers.id) DESC")
    .limit(5)
  end
end
