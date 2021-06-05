class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  # validates_presence_of :credit_card_expiration_date
  # validates :credit_card_expiration_date, presence: true 

  validates_presence_of :result

  belongs_to :invoice

  enum result: ['success', 'failed']
end
