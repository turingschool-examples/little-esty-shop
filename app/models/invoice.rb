class Invoice < ApplicationRecord
    belongs_to :customer

    has_many :transactions, dependent: :destroy
    has_many :invoice_items, dependent: :destroy
    has_many :items, through: :invoice_items
    has_many :merchants, through: :items

    enum status: ['in progress', 'cancelled', 'completed']
end
