class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items

  def self.top_five_customers
    joins(:transactions)
    .where("result = 'success'")
    .group(:id)
    .select("customers.*, count('transactions.result') as transaction_count")
    .order(transaction_count: :desc)
    .limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def succsessful_transaction_count
    transactions.where("result = 'success'")
    .count
  end
end
