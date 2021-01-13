class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :invoice_id
  
  belongs_to :invoice
end


