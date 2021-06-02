# app/models/customer

class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
end