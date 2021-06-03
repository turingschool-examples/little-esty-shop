class Transaction < ApplicationRecord
  enum status: [:success, :failed]    
end