class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true

  def num_succesful_transactions
    invoices.joins(:transactions).count
  end
end