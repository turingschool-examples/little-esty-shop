class Transaction < ApplicationRecord
  enum result: { success: 0, failed: 1 }
  belongs_to :invoice
  has_many :invoice_items, through: :invoice
  has_many :items, through: :invoice_items
  has_many :customers, through: :invoice

  scope :successful_transactions, -> { where('transactions.result =?', 0) }
end
