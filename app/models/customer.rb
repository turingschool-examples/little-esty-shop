class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.five_top_customers
    joins(:transactions).where('result = 0').group(:first_name).order(count: :desc).limit(5).count
  end
end
