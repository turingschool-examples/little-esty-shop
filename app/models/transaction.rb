class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :invoice_id #:credit_card_expiration_date
  
  enum result: [:success, :failed]

  belongs_to :invoice
end
