class Item < ApplicationRecord
    validates_presence_of :name, :description, :unit_price
    enum status: { Enabled: 0, Disabled: 1 }

    belongs_to :merchant
    has_many :invoice_items
    has_many :invoices, through: :invoice_items
    has_many :transactions, through: :invoices
    has_many :customers, through: :invoices

    def self.top_five_items
        self.joins(:transactions)
        .where(invoices: {status: 2}, transactions: {result: 'success'})
        .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
        .group(:id)
        .order("revenue desc")
        .limit(5)
    end

end


