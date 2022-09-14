class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true

  def transactions_top_5
    Customer.joins(invoices: :transactions).where( transactions: {result: 1}).group(:id).order("transactions.count desc").limit(5)
  end
end