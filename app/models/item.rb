class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :enabled, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum enabled: {enabled: 0, disabled: 1}

  def item_best_day
    Item.joins(invoice_items: {invoice: :transactions})
      .where(transactions: {result: 0})
      .select("invoices.*, SUM(invoice_items.quantity)")
      .group("invoices.id, items.id")
      .order(sum: :desc) # sum all the quantites for each date
      .first.created_at
  end
end
