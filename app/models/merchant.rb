class Merchant < ApplicationRecord
    validates_presence_of :name

    has_many :items
    has_many :invoice_items, through: :items
    has_many :invoices, through: :invoice_items
    has_many :transactions, through: :invoices
    has_many :customers, through: :invoices

    def ready_to_ship
      invoice_items.joins(:invoice).where.not("invoice_items.status = ?", 2).order('invoices.created_at')
    end
end
