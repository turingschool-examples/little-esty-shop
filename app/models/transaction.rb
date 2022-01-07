class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :invoice_items, through: :invoice
  validates :credit_card_number, :result, presence: true
end
