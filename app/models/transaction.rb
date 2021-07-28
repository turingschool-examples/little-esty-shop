class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :credit_card_number
  validates :credit_card_number, numericality: { only_integer: true }, length: { is: 16 }
  validates :result, inclusion: { in: [ true, false ] }
end
