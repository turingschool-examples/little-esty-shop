class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, presence: true

  enum result: {"success" => 0, "failed" => 1}

  scope :successful, ->{where(result: 0)}
end
