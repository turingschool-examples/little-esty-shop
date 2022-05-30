class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :credit_card_number, :result
  validates_presence_of :credit_card_expiration_date, presence: false
end
