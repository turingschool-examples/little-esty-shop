class Item < ApplicationRecord
  validates_presence_of :name, :description
  validates :unit_price, numericality: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def change_status(status)
    self.item_status = status
    self.save
  end

  def self.enabled_items
    where(item_status: true)
  end

  def self.disabled_items
    where(item_status: false)
  end

  def best_day
    invoices.joins(:invoice_items).joins(:transactions).select('invoices.*, Sum(invoice_items.quantity * invoice_items.unit_price) AS Revenue').group("invoices.id, DATE_TRUNC('day',invoices.created_at)").max.created_at

  end
end
