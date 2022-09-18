class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.top_customers
    Customer.select("customers.*", 'count(transactions)').joins(invoices: :transactions).where('transactions.result' => 1).order('count desc').group(:id).limit(5)
  end
end