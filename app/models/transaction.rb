class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result
  validates :credit_card_number, numericality: true

  belongs_to :invoice

  enum result: ['success', 'failed']
end
