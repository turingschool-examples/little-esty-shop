class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :result
  validates :credit_card_number, presence: true, length: {is: 16}
end
