class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def items_ready_to_ship
    ### Active Record Method to get the items based on the invoice item status == pending ### HALP
    Merchant.joins(invoice_items: [invoice: :transactions]).where(merchants: {id: self.id}, invoice_items: {status: [0, 1]}, invoices: {status: [0]}, transactions: {result: 'success'}).select("items.name, invoices.id")
  end

  def top_5_customers
    customers
    .joins(:invoices, :transactions)
    .select("customers.*, count(transactions.id) as no_of_transactions")
    .group("customers.id").where(transactions: {result: :success})
    .order("no_of_transactions desc, customers.last_name").limit(5)
  end
end
