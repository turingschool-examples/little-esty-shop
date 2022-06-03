class Invoice < ApplicationRecord
    belongs_to :customer

    has_many :transactions, dependent: :destroy
    has_many :invoice_items, dependent: :destroy
    has_many :items, through: :invoice_items
    has_many :merchants, through: :items

    enum status: ['in progress', 'cancelled', 'completed']

    def total_revenue(merchant_id)
      invoice_items.joins(:item).where(items: {merchant_id: merchant_id }).sum("invoice_items.unit_price * invoice_items.quantity")
    end
end
