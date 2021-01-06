class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  def self.top_5
    joins(:transactions)
    .select('customers.*, count(transactions.result) as transaction_count')
    .where(transactions: {result: 1})
    .group(:id)
    .order('transaction_count DESC')
    .limit(5)
  end
end
