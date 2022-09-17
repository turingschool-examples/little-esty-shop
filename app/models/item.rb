class Item < ApplicationRecord
    validates_presence_of :name, :description, :unit_price
    enum status: { Enabled: 1, Disabled: 0}

    belongs_to :merchant
    has_many :invoice_items
    has_many :invoices, through: :invoice_items
    has_many :transactions, through: :invoices
    has_many :customers, through: :invoices
end


