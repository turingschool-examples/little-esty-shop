class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :credit_card_number
  enum result:["success", "failed"]
end
