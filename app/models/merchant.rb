class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices

  def top_5_customers
    # binding.pry
    customers.joins(invoices: :transactions)
      .select('customers.*, count(transactions) as successful_transactions')
      .where('transactions.result = ?', "success")
      .group(:id)
      .order('successful_transactions desc')
      .limit(5)
      # binding.pry
  end
end
