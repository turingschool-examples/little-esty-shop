class Transaction < ApplicationRecord
  belongs_to :invoice
  has_one :customer, through: :invoice
  has_many :invoice_items, -> { distinct }, through: :invoice
  has_many :items, -> { distinct }, through: :invoice_items
  has_many :merchants, -> { distinct }, through: :items

  validates :credit_card_number, presence: true
  validates :result, inclusion: [true, false]
end
