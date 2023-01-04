class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy
  has_many :merchants, through: :items, dependent: :destroy

  def self.top_5_customers_by_successful_transactions
    joins(:transactions).where(transactions: {result: "success"}).select("customers.*, count(result) as count_result").group(:id).order("count_result desc").limit(5)
  end
end