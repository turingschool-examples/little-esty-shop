class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  scope :with_successful_transactions, -> { joins(invoices: :transactions)
          .where("transactions.result =?", 0)}
end
