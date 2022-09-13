class Transaction < ApplicationRecord
  enum result: { failed: 0, success: 1 }
end