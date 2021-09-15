class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, numericality: true

  enum enable: {
    enabled: 0,
    disabled: 1
  }

  def self.enabled_items
    where(enable: 0)
  end

  def self.disabled_items
    where(enable: 1)
  end

  # def all_merchants_invoices(merchant_id)
  #   require "pry"; binding.pry
  #   invoices.where("merchant_id = ?", merchant_id)
  # end

  def ordered_invoices
    invoices.order(:created_at)
  end

  def best_day
    invoices
      .select("DATE_TRUNC('day', invoices.created_at) as created_at, SUM(invoice_items.quantity * invoice_items.unit_price) as sales")
      .group(:created_at)
      .order(sales: :desc, created_at: :desc)
      .limit(1)
      .first
  end

  def revenue
    invoice_items.sum('quantity * unit_price')
  end
end
