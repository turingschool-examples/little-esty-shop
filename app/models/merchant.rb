class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customers
    customers
    # .joins(:transactions)
    .group(:id)
    # .where('transactions.result = ?, success')
    # .limit(5)
  end
end
