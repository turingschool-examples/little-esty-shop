class Customer < ApplicationRecord
  has_many :invoices, dependent: :delete_all
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  validates :first_name, presence: true
  validates :last_name, presence: true
end
