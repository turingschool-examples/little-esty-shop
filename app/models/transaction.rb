class Transaction < ApplicationRecord
  belongs_to :invoice
  # belongs_to :invoice_item, through: :invoice
  # belongs_to :item, through: :invoice_item
  # belongs_to :merchant, through: :item
  validates_presence_of :credit_card_number, :result
end
