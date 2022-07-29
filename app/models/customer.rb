class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices

  def successful_transactions
    Customer.joins(invoices: :transactions).where('result = ?', 0).count
  end

end
