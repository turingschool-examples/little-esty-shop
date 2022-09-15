class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  # def top_customers
  #   customers.joins(:transactions).where('result = 0').group(:first_name).order(count: :desc).limit(5).count
  # end
end
