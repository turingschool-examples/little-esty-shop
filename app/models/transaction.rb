class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :invoice_items, through: :invoice

  validates_presence_of :credit_card_number
  validates_presence_of :result

end
