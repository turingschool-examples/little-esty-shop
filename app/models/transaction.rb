class Transaction < ApplicationRecord
  enum status: [:success, :failed]
  belongs_to :invoice 
end
