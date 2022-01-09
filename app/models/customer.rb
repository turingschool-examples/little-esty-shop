class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  validates :first_name, :last_name, presence: true

  def transaction_count
    transactions.count
  end

  def self.top_5
    joins(invoices: :transactions)
      .select("customers.*, count(transactions.id) as transaction_count")
      .limit(5)
      .group(:id)
      .order(transaction_count: :desc)
      .where(transactions: { result: 1 })
  end
end
