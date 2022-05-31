class Transaction < ApplicationRecord
  # make instance method for result boolean
  belongs_to :invoice
end
