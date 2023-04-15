class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum status: ["in progress", "completed", "cancelled"]

  def total_revenue
    accumulated_revenue = 0
    invoice_items.each do |invoice_item|
      accumulated_revenue += (invoice_item.quantity * invoice_item.unit_price)
    end
    accumulated_revenue
  end

  

  def self.incomplete
    joins(:invoice_items)
    .where(invoice_items: {status: [0, 2]})
    .distinct
    .pluck(:id)
  end
end
