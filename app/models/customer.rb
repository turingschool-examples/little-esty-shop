class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :invoices, dependent: :destroy

  def self.top_five
    joins(invoices: :transactions)
    .group(:id)
    .where("transactions.result = ?", 1)
    .select("customers.*, count(transactions.id) as num_transactions")
    .order(num_transactions: :desc)
    .limit(5)
  end
end
