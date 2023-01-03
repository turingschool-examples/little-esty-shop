class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_numericality_of :credit_card_number, length: { is: 16 }
end
