class Customer < ApplicationRecord
  has_many :invoices
  has_many :items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :items

  def self.top_five_customers
    all
    .joins(invoices: :transactions)
    .where('transactions.result = ?', 'success')
    .group('id')
    .order('transactions.count DESC')
  end
end
