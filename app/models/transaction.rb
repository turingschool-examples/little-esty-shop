class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :result, presence: true
  validates :invoice_id, presence: true
  belongs_to :invoice
end
