class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true, numericality: true
  validates :result, presence: true, numericality: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  belongs_to :invoice
end
