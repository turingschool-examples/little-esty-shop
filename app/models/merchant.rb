class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  enum status: { enabled: 0, disabled: 1 }

  def all_invoice_ids
    self.invoice_items.distinct.pluck(:invoice_id) #uniq is a ruby method
  end

  def top_customers
            Customer.select("customers.*, COUNT (transactions.id) AS trans_count")
            .distinct
            .joins(invoices: [:transactions, :merchants])
            .where("transactions.result = 0 AND merchants.id = ?", self.id)
            .group("merchants.id, customers.id")
            .order(trans_count: :desc)
            .limit(5)
  end

  def toggle_status
    self.status == "enabled" ? self.disabled! : self.enabled!
  end

  def self.group_by_status(status)
    self.where(status: status)
  end
end
