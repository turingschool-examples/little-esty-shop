class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items


  def self.top_5_by_transaction_count
    joins(invoices: :transactions)
    .where(transactions: {result: 1})
    .group(:id)
    .select("customers.*, count(transactions.id) as successful_transaction_count")
    .order(successful_transaction_count: :desc)
    .limit(5)
  end

  def full_name
    first_name + " " + last_name
  end
end
