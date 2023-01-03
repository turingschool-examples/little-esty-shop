class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name
end