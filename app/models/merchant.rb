class Merchant < ApplicationRecord
    has_many :invoices
    has_many :customers, through: :invoices
    has_many :items

end
