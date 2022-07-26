class Transaction < ApplicationRecord
    validates_presence_of :credit_card_number
    validates :result, presence: true

    belongs_to :invoice
end