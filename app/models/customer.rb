class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, -> { distinct }, through: :invoice_items
  has_many :merchants, -> { distinct }, through: :items

  validates :first_name, presence: true
  validates :last_name, presence: true
end
