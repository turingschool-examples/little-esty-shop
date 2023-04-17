class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum status: ["in progress", "completed", "cancelled"]

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def created_at_formatted
    created_at.strftime("%A, %B %d, %Y")
  end

  def customer_full_name
    "#{customer.first_name} #{customer.last_name}"
  end

  def self.incomplete
    select("id, created_at")
    joins(:invoice_items)
    .where(invoice_items: {status: [0, 2]})
    .distinct
  end

  def self.incomplete_id
    incomplete
    .pluck(:id)
  end
end
