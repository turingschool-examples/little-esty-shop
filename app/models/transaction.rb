class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :credit_card_expiration_date, :result
  validates_length_of :credit_card_number
  belongs_to :invoice
  enum result: { success: 0, failed: 1 }
end