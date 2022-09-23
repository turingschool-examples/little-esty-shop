class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Class Methods
  def self.top_5_customers
    Customer.joins(invoices: :transactions).where( transactions: {result: 1})
            .group(:id).order('transactions.count DESC').limit(5)
  end

  # Instance Methods
  def num_succesful_transactions
    invoices.joins(:transactions).where(transactions: { result: 1 }).count
  end

  def name
    "#{first_name} #{last_name}"
  end
end