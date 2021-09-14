class Customer < ApplicationRecord
  has_many :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true
end
