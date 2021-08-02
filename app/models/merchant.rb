class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.enabled_merchants
    where("status = ?", "enabled")
  end

  def self.disabled_merchants
    where("status = ?", "disabled")
  end

  def self.top_5_merchants_revenue
    require "pry"; binding.pry
  end
end
