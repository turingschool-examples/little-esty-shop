class Customer < ApplicationRecord
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  def self.top_five_customers
   joins(:transactions)
   .select("customers.*, count('transactions.result') AS transaction_count")
   .group(:id)
   .where('transactions.result = ?', 1)
   .order('transaction_count desc')
   .limit(5)
  end

  def successful_purchases
    transactions.where('result = ?', 1).count
  end

  def name
    first_name + " " + last_name
  end
end
