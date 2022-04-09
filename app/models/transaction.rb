class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result: {success: 0, failed: 1}

  validates_presence_of :credit_card_number
  validates_presence_of :result
  validates_presence_of :created_at
  validates_presence_of :updated_at

end
