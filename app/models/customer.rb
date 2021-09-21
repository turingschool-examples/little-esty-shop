class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :invoices, dependent: :destroy

  def create
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.top_admin_5_customers
    joins(invoices: :transactions)
    .select('customers.*, count(transactions.result) as successful')
    .group('customers.id')
    .where(transactions: {result: 0})
    .order(successful: :desc)
    .limit(5)
  end
end
