class Transaction < ApplicationRecord
  belongs_to :invoice
  validates :credit_card_number, :result, :created_at, :updated_at, presence: true

  enum result: [:failed, :success]
end
