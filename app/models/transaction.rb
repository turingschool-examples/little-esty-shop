class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :credit_card_number

  validates :credit_card_number, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 9999999999999999 }

  validates :result, inclusion: { in: [ true, false ] }
end
