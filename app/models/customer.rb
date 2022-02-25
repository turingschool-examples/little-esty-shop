class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions,through: :invoices
  validates_presence_of :first_name
  validates_presence_of :last_name

  def name
    first_name + " " + last_name
  end

  def transaction_count
    transactions.count
  end

  def successful_transactions_count
    transactions.where(result: 1).count
  end
end
