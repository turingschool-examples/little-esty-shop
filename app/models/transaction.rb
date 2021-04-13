class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :credit_card_expiration_date, :result
  validates :credit_card_number, presence: true, length: {is: 16}
end
