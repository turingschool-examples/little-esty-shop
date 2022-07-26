class Transaction < ApplicationRecord
  enum status: {failed: 0, success: 1}

  belongs_to :invoice
end