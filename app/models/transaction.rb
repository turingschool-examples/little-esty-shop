class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: [:success, :failed]
end
