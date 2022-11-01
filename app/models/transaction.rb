class Transaction < ApplicationRecord
  enum result: { success: 0, failed: 1 }
  belongs_to :invoice 
end