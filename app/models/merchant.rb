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

  def self.top_five
    self.joins(invoices: [:invoice_items, :transactions])
        .where('result = 0')
        .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
        .group(:id)
        .order('total_revenue desc')
        .first(5)
  end

  def total_revenue
    self.invoices
        .joins(:invoice_items, :transactions)
        .where('transactions.result = 0')
        .select('invoices.*')
        .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
