class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name, :last_name

  def self.top_5_transactions
    self.joins(:transactions)
        .group("customers.id")
        .where(transactions: { result: "success" } )
        .order("count(transactions.id) desc")
        .limit(5)
  end

  def successful_transactions
    transactions.success.count
  end
end