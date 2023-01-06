class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :merchants, through: :invoice

  enum result: ["failed", "success"]
end