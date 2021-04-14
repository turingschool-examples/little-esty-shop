class Transaction < ApplicationRecord
  has_many :items, through: :invoice_items
  enum result: [ :failed, :success ]
end
