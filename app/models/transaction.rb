class Transaction < ApplicationRecord
  belongs_to :invoice
  belongs_to :customer, through: :invoice

  validates_presence_of :credit_card_number, :result
end