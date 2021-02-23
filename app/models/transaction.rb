class Transaction < ApplicationRecord
  belongs_to :invoice
  validates :credit_card_number, numericality: {
            greater_than_or_equal_to: 0
          }
  enum result: [:success, :failed]
end
