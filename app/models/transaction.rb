class Transaction < ApplicationRecord
  enum result:[:success, :failed]
end
