class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  validates :credit_card_number, length: { is: 16 }
  belongs_to :invoice
  enum result: { success: 0, failed: 1 }
end