class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.top_customers
    joins(invoices: :transactions)
    .where(transactions: {result: 0})
    .select('customers.*, count(transactions) as total_count')
    .group(:id)
    .order(total_count: :desc)
    .limit(5)
  end
end
