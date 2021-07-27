class Transaction < ApplicationRecord
  enum result: { success: 0, failed: 1 }

  belongs_to :invoice

  validates :credit_card_number, presence: true
  # validates :credit_card_expiration_date, presence: true
  validates :result, presence: true, inclusion: { in: Transaction.results.keys }

end
