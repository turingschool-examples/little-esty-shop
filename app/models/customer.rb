class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy
  has_many :merchants, through: :items, dependent: :destroy

  def self.merchant_top_customers
    joins(:invoices, :transactions)
      .where(transactions: { result: "success"})
      .group(:id).select('customers.*, count(result) as num_transactions')
      .order(num_transactions: :desc)
      .limit(5)
  end
end