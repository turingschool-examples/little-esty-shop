class Customer < ApplicationRecord
    has_many :invoices
    has_many :items, through: :invoice_items
end
