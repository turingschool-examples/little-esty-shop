class Customer < ApplicationRecord
    has_many :invoices
    has many :merchants, through: :invoices
end
