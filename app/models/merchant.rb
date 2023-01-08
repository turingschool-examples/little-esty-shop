class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoice_items
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

  def top_5_revenue_items
    self.items
        .joins(:transactions)
        .group(:id)
        .where(transactions: { result: "success" })
        .order(Arel.sql("sum(invoice_items.unit_price * invoice_items.quantity) desc"))
        .limit(5)
  end
end
