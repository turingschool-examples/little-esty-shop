class Merchant < ApplicationRecord
  validates :name, presence: true
  validates_inclusion_of :enabled, in: [true, false]

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def enabled_items
    Item.where(merchant_id: self.id).where(enabled: "enabled")
  end

  def disabled_items
    Item.where(merchant_id: self.id).where(enabled: "disabled")
  end

  def popular_items
    Item.joins(invoice_items: {invoice: :transactions})
        .where(transactions: {result: 0}, merchant_id: self.id) #might not need merch id
        .group(:id)
        .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue, items.*')
        .order('revenue desc')
        .limit(5)
  end
end
