class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.top_five_customers
    joins(invoices: [:transactions])
    .group(:id).where(transactions: {result: 0})
    .select('customers.*, count(result) as success_count')
    .order(success_count: :desc)
    .limit(5)
  end

end
