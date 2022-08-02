class Merchant < ApplicationRecord
    validates_presence_of :name
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

    def top_5_items
      items.joins(:invoice_items, invoices: :transactions)
      .where(transactions: {result: 1})
      .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .group(:id)
      .order(revenue: :desc)
      .limit(5)   
  end
end
