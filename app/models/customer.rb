class Customer < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices

  validates :first_name, :last_name, :presence => true
  
  def self.top_five_customers
    select("customers.*, count(transactions.*) AS transactions")
      .joins(invoices: :transactions)
      .where('transactions.result = ?', 'success')
      .group('customers.id')
      .order('transactions DESC')
      .limit(5)
  end
end