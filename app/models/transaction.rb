class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, presence: true
  validates :result, presence: true

  enum result: { 'success' => true, 'failed' => false }
end
