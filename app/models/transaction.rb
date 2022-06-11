class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :customers, through: :invoice
  has_many :invoice_items, through: :invoice
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  validates :credit_card_number, presence: true
  validates :result, presence: true

  enum result: { 'success' => true, 'failed' => false }
end
