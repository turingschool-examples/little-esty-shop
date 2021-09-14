class Transaction < ApplicationRecord
  belongs_to  :invoice

  validates :credit_card_number, numericality: { only_integer: true }, presence: true
  validates :result, numericality: { only_integer: true }, presence: true
end
