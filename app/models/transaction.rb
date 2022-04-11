class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :credit_card_number
  validates_presence_of :result

  enum result: {"success" => 0, "failed" => 1}


end
