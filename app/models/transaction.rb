class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  validates_presence_of :credit_card_number, :result
  validates :credit_card_number, numericality: { only_integer: true }

  enum result: {success: 0,
                failed: 1}
end