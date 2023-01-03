class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_presence_of :credit_card_number, :result
  validates :credit_card_number, numericality: { only_integer: true }

  enum result: {success: 0,
                failed: 1}
end