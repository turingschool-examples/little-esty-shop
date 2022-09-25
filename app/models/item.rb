class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  validates :unit_price, numericality: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :discounts, through: :merchant
  enum active_status: { disabled: 0, enabled: 1  }

  def self.active
    where(active_status: :enabled)
  end

  def self.inactive
    where(active_status: :disabled)
  end

  def quantity_purchased(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id).quantity
  end

  def price_sold(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id).unit_price
  end

  def shipping_status(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id).status
  end

  def self.top_5_order_by_revenue
    joins(invoice_items:[invoice:[:transactions]])
    .group(:id)
    .where(transactions: { result: 0 })
    .select('items.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
    .order('total_revenue desc')
    .limit(5)
  end

  def revenue
    invoice_items.joins(invoice:[:transactions])
    .where(transactions: { result: 0 })
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.total_revenue_of_all_items
    joins(invoice_items:[invoice:[:transactions]])
    .where(transactions: { result: 0 })
    .sum('(invoice_items.unit_price * invoice_items.quantity)')
  end

end
