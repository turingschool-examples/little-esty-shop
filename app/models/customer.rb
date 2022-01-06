class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_one :merchant, through: :items
  validates :first_name, presence: true
  validates :last_name, presence: true

  # def successful_transactions
  # end
end
