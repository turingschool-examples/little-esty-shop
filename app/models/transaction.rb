class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :merchants, through: :invoice
end