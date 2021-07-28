class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, presence: true, numericality: {only_integer: true }, length: { is: 16 }

  validates :result, inclusion: { in: [ true, false ] }
end
