class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :invoices, dependent: :destroy

  def self.top_five
    # self.joins(invoices: :transactions)
    # self.joins(invoices: :transactions).where("transactions.result = ?", 1)
    # self.joins(invoices: :transactions).group(:id).where("transactions.result = ?", 1).select("customers.first_name, customers.last_name, count(transactions.id) as num_transactions")
    # self.joins(invoices: :transactions).group(:id).where("transactions.result = ?", 1).select("customers.first_name, customers.last_name, count(transactions.id) as num_transactions").order(num_transactions: :desc)
    joins(invoices: :transactions)
    .group(:id)
    .where("transactions.result = ?", 1)
    .select("customers.*, count(transactions.id) as num_transactions")
    .order(num_transactions: :desc)
    .limit(5)
  end
end
