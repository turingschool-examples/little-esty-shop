class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :credit_card_expiration_date, presence: true
  validates :result, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  belongs_to :invoice
end
