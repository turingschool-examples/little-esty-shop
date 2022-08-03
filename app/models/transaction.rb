class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  validates_presence_of :result
  validates_presence_of :invoice_id

  belongs_to :invoice

  # enum result: {failed: 0, success: 1 }
end
