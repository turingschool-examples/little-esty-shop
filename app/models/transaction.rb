class TransactionItem < ApplicationRecord
  validates :credit_card_number, presence: true, numericality: true
  # validates :credit_card_expiration_date  ##BLANK
  validates :result, presence: true
  enum result: [ :failed, :success ]

  belongs_to :invoice, foreign_key: true
end
