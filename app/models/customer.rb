class Customer < ApplicationRecord
  has_many :invoices
  has_many :customers, through: :invoices

  validates :first_name, :last_name, :presence => true
  
  def self.top_five_customers
    select("customers.*, count(transactions.*) AS succ_transactions")
      .joins(invoices: :transactions)
      .where('transactions.result = ?', 'success')
      .group('customers.id')
      .order('succ_transactions DESC')
      .limit(5)
  end
end