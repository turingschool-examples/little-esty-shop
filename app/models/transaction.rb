class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: {
    success: 0,
    failed: 1
  }

  scope :purchase, -> { where(result: 0) }
end
