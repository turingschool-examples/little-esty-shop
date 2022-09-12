class Transaction < ApplicationRecord
  enum result: ["Success", "Failed"]

  validates_presence_of :credit_card_number
  validates_presence_of :result, inclusion: ["Success", "Failed"]
  validates_presence_of :invoice_id

  belongs_to :invoice

end