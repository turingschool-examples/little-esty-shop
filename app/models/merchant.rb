class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true

  def merchant_invoices
    Invoice.joins(:items).where("items.merchant_id = ?", id)
  end

  def self.enabled_merchants
    Merchant.where(status: true)
  end

  def self.disabled_merchants
    Merchant.where(status: false)
  end
end
