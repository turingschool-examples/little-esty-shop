class Merchant < ApplicationRecord
    has_many :items, dependent: :destroy
    has_many :invoice_items, through: :items, dependent: :destroy
    has_many :invoices, through: :invoice_items, dependent: :destroy
    has_many :customers, through: :invoices, dependent: :destroy
    has_many :transactions, through: :invoices, dependent: :destroy
end