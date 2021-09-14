class Customer < ApplicationRecord
  self.primary_key = :id

  has_many :invoices, dependent: :destroy
end
