class Invoice < ApplicationRecord
    belongs_to :customer
    has_many :invoice_items
    has_many :items, through: :invoice_items

    enum status: ['in progress', 'cancelled', 'completed']
end
