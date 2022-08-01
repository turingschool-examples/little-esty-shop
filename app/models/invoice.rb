class Invoice < ApplicationRecord
  validates_presence_of :status, presence: true

  belongs_to :customer
  
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  enum status: { "in progress": 0, "completed": 1, "cancelled": 2 }

  def total_revenue
    revenue_generated = 0
    invoice_items.each do |invoice_item|
      revenue_generated += (invoice_item.quantity * invoice_item.unit_price)
    end
    revenue_generated
  end
end
