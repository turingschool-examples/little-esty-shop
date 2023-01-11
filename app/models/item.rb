class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name, :description, :unit_price, :merchant_id

  enum status: { 'disabled' => 0, 'enabled' => 1}

  def change_status
    if self.status == 'disabled'
      self.enabled!
    else
      self.disabled!
    end
  end

  def self.enabled_items
    where(status: "enabled")
  end

  def self.disabled_items
    where(status: "disabled")
  end

  def top_selling_days
    invoices.joins(:transactions)
    .where(transactions: {result: "success"}, invoices: {status: 1})
    .select('invoices.*, invoices.created_at as invoice_date, sum(invoice_items.quantity * invoice_items.unit_price) as item_revenue')
    .group('invoices.id')
    .order(item_revenue: :desc, invoice_date: :desc)
    .first
    .invoice_date
  end
end