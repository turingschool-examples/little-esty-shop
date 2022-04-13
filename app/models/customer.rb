class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices

  def successful_transactions
    transactions.where(result: 'success')
  end
end
