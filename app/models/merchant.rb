class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true

  def self.enabled_merchants
    where(status: true)
  end

  def self.disabled_merchants
    where(status: false)
  end

  def merchant_invoices
    Invoice.joins(:items).where("items.merchant_id = ?", id)
  end

  def enabled
    items.where(status: 1)
  end

  def disabled
    items.where(status: 0)
  end

  def packaged_items
    items.joins(:invoice_items).where('invoice_items.status = ?', 0)
  end
end
