class Transaction < ApplicationRecord
  enum result: [ :failed, :success]

  belongs_to :invoice
end