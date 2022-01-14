class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  def successful_transactions_count
    successful_transactions.count
  end

  def successful_transactions
    transactions.where(result: 0).distinct
  end

  def full_name
    (self.first_name) + " " + (self.last_name)
  end
end
