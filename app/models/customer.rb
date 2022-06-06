class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_five
    self.joins(:transactions)
    .where("transactions.result = ?", 0)
    .group("customers.id")
    .select("customers.*, count(transactions) as transaction_count")
    .order(transaction_count: :desc)
    .order(:first_name)
    .order(:last_name)
    .limit(5)
  end
end
