class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :invoices

  def self.top_five_customers
    joins(invoices: :transactions).where(transactions: { result: 0})
      .select('customers.*, count(transactions) as trans_count')
      .group(:id)
      .order(trans_count: :desc)
      .limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
