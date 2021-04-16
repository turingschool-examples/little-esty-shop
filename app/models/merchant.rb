class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :customers


  def self.top_five_by_successful_transaction_count
    # joins(:transactions)
    # .where(transactions: {result: 1})
    # .group("customer.id")
    # .select("customers.*, count(transactions.id) as successful_transaction_count")
    # .order(successful_transaction_count: :desc)
    # .limit(5)
  end
end
