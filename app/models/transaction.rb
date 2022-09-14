class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result
  enum result: {success: 0, failed: 1}

  belongs_to :invoice
end