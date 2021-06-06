class Transaction < ApplicationRecord
  belongs_to :invoice

  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates :credit_card_number, presence: true, numericality: true

  enum result: { failed: 0, success: 1 }, _prefix: :status
end
