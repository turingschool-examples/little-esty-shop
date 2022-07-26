class Transaction < ApplicationRecord
  enum status: {failed: 0, success: 1}
end