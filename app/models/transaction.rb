class Transaction < ApplicationRecord
  belongs_to :invoice
  has_one :merchant, through: :invoice

  validates_presence_of :credit_card_number, :result, :invoice_id

  enum result: { success: 0, failed: 1 }
end
