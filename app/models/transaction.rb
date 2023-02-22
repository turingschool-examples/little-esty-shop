class Transaction < ApplicationRecord
  has_many :invoices
end
