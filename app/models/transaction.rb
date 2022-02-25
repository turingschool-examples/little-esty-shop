class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: {"failed" => 0, "success" => 1 }

  validates_presence_of :credit_card_number
  validates_presence_of :result

end
