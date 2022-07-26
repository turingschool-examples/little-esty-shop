class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  validates_numericality_of :credit_card_number
  validates_presence_of :credit_card_expiration_date
  validates_numericality_of :credit_card_expiration_date
  validates_presence_of :result
  belongs_to :invoice

  enum result: { 'failed' => 0, 'success' => 1 }
end
