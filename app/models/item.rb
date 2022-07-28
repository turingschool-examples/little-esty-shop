class Item < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :unit_price
    validates_presence_of :created_at
    validates_presence_of :updated_at

    has_many :invoice_items
    has_many :invoices, through: :invoice_items
    belongs_to :merchant 
    has_many :transactions, through: :invoices
    has_many :customers, through: :invoices

    def invoice_quantity(invoice_id)
        invoice_items.where(invoice_items:{invoice_id: invoice_id})
    end
end 