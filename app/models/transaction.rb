class Transaction < ApplicationRecord
  belongs_to :invoice
  validates :invoice, :credit_card_number, presence: true

    enum result: {
    failed: 0,
    success: 1
  }
end
