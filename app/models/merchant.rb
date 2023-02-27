class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  enum status: [ "enabled", "disabled" ]

  def toggle_status
    self.status == "enabled" ? self.disabled! : self.enabled!
  end

  def mech_top_5_successful_customers
    customers.joins(:transactions)
    .select("customers.*, COUNT(transactions.id) AS transaction_count")
    .where(transactions: {result: 0})
    .group("customers.id")
    .order("transaction_count DESC")
    .limit(5)
  end
  
  def unshipped_items
    # invoice_items.select("invoice_items.*, items.name AS item_name")
    # .where("invoice_items.status != 2")
    # .order("invoice_items.invoice_created_at")
    invoices.select("invoice_items.status, invoices.*, items.name AS item_name")
    .where("invoice_items.status != 2")
    .order(:created_at)
  end
end