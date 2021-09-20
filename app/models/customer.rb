class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.five_best_customers
    joins(invoices: :transactions).group('customers.id').where('transactions.result = ?', 'success').select('customers.*, count(transactions.result) as transaction_count').order(transaction_count: :desc).limit(5)
  end
end
