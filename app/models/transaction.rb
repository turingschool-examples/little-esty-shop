class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :result, presence: true
  validates :invoice_id, presence: true
    belongs_to :invoice
  has_many :invoice_items, through: :invoice
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :customers, through: :invoices
end
