class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices
  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.top_merchant_transactions
    joins(invoices: [:transactions])
      .where('transactions.result=0')
      .group(:id)
      .select('customers.*, count(transactions) as count_success')
      .order(count_success: :desc)
      .limit(5)
  end
end
