class Merchant < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :created_at
    validates_presence_of :updated_at

    has_many :items 
    has_many :invoice_items, through: :items 
    has_many :invoices, through: :invoice_items 

    def self.top_five_merchants 
        select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue').joins(:invoice_items, invoices: :transactions).group('merchants.id').where(transactions: { result: 'success' }).order('revenue desc').limit(5)
        # select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue').joins(:invoice_items, invoices: :transactions).group('merchants.id').where(transactions: { result: 'success' }).where(merchants: { status: 'enabled'}).order('revenue desc').limit(5)
    end 
end 