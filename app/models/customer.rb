class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Class Methods
  def self.top_5_customers
    Customer.joins(invoices: :transactions).where( transactions: {result: 1})
            .group(:id).order("transactions.count desc").limit(5).count
  end
  
  # Instance Methods
  def num_succesful_transactions
    invoices.joins(:transactions).count
  end

  def name
    "#{first_name} #{last_name}"
  end
end