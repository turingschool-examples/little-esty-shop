class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  enum status: [ "in progress", "completed", "cancelled" ]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def self.most_transactions_date
    joins(:transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .order('COUNT(transactions.id)DESC, created_at DESC')
    .limit(1)
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where("invoice_items.status != 2")
    .group(:id)
    .order(:created_at)
  end
end