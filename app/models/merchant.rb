class Merchant < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :created_at
    validates_presence_of :updated_at
    has_many :items
    has_many :invoice_items, through: :items
    has_many :invoices, through: :invoice_items
    has_many :customers, through: :invoices
    has_many :transactions, through: :invoices

    def merchant_invoices
      invoices.distinct
    end
    
    def ready_to_ship
      invoice_items.joins(:invoice).where.not("invoice_items.status = ?", 2).order('invoices.created_at')
    end
end
