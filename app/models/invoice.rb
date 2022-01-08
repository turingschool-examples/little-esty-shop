class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :transactions

  enum status: [:cancelled, 'in progress', :completed]

  def incomplete_invoices
    invoice_items.where(status: [0, 1])
  end

  def self.ordered_invoices
    order(created_at: :asc)
  end

  def total_revenue
    invoice_items.sum(:unit_price)
  end
end
