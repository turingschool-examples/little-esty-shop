# app/models/transaction

class Transaction < ApplicationRecord
  belongs_to :invoice
end