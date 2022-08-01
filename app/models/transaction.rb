class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  validates_presence_of :result
  belongs_to :invoice

  has_many :customers, through: :invoice
  has_many :invoice_items, through: :invoice
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum result: { 'failed' => 0, 'success' => 1 }
end
