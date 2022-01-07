class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, :through => :invoices
  has_many :invoice_items, :through => :invoices
  has_many :items, :through => :invoice_items
  has_many :merchants, :through => :items

  def self.favorite_customers

    select("customers.*, count(customers.id) as count").joins(:invoices, :transactions).joins(:invoice_items, :items).where(transactions: {result: "success"}).group("customers.id").limit(5).order("count")

  end
end
