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


    def total_revenue
        invoice_items.sum("quantity * unit_price")
    end

    def invoice_quantity(invoice_id)
        invoice_items.where(invoice_items:{invoice_id: invoice_id})
    end

    def best_revenue_day
      invoices.joins(:invoice_items).joins(:transactions).select('invoices.created_at AS date, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue').group('date').order('revenue desc, date desc').limit(1)
    end
end
