class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def enable
    self.update(status: true)
  end

  def disable
    self.update(status: false)
  end

  def self.group_by_enabled
    Merchant.where('status = ?', true)
  end

  def self.group_by_disabled
    Merchant.where('status = ?', false)
  end

  def self.top_five_by_revenue #is this working?? transactions with at least one success??
    Merchant.joins(items: :invoices).joins(invoices: :transactions)
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .group(:id)
    .where('transactions.result = 0')
    .order('total_revenue desc')
    .limit(5)
  end

  def top_sale_date_for_merchant
  end
end
