class Customer < ApplicationRecord
  has_many :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  def successful_transactions_count
    invoices.where(status: :completed).count
  end

  def full_name
    (self.first_name) + " " + (self.last_name)
  end

  def self.trans
    binding.pry
    self.invoices.transactions
    # Transactions.all
  end
end
