class Customer < ApplicationRecord
  has_many :invoices, dependent: :delete_all
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.transaction_count(id)
    Customer.find(id).transactions.count
  end
end
