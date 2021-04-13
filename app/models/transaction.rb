class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true, numericality: true
  # validates :credit_card_expiration_date  #is empty string '' in file
  validates :result, presence: true  #is string, but should be integer status?

  belongs_to :invoice

end
