class Transaction < ApplicationRecord
  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :credit_card_expiration_date,
                        :result

  belongs_to :invoice 
end
