class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_presence_of :credit_card_number, :result

  enum result: {success: 0,
                failed: 1}
end