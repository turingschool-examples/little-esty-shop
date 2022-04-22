class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: {"Cancelled" => 0, "In Progress" => 1, "Completed" => 2}

  def total_revenue
    invoice_items.sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.incomplete_invoices
    joins(:invoice_items)
      .where("invoice_items.status = 0 OR invoice_items.status = 1")
      .group("invoices.id")
      .order(created_at: :asc)
  end
end
