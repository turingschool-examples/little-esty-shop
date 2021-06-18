class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: {pending: 0, failed: 1, success: 2}
end
