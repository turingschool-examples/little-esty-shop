class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :customers, through: :invoice
  enum result: { success: 0, failed: 1 }

  validates :credit_card_number, presence: true
end
