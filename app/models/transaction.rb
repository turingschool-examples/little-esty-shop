class Transaction < ApplicationRecord
  enum result: [ :failed, :success]
end