class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  has_many :invoices, dependent: :destroy


  def full_name
    "#{first_name} #{last_name}"
  end

  def self.top_five_customers
    joins(invoices: :transactions)
    .where(transactions: { result: 0})
    .select('customers.*, count(transactions.*) as total_transactions')
    .order(total_transactions: :desc)
    .group('customers.id')
    .limit(5)
  end
end
