class Transaction < ApplicationRecord
  belongs_to :invoice
  enum status: [ :success, :failed]
end
