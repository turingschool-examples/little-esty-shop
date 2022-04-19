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
end
