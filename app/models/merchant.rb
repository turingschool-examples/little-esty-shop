class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name

  enum status: { enabled: 0, disabled: 1 }

  def all_invoice_ids
    self.invoice_items.pluck(:invoice_id).uniq
  end

  def toggle_status
    self.status == "enabled" ? self.disabled! : self.enabled!
  end

  def self.group_by_status(status)
    self.where(status: status)
  end

  def self.top_five
    self.joins(invoices: [:invoice_items, :transactions])
    .where('result = 0')
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .group(:id)
    .order('total_revenue desc')
    .first(5)
  end
end
