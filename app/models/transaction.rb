class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, presence: true, numericality: true

  enum result: { failed: 0, success: 1 }, _prefix: :status
end
