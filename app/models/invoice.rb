class Invoice < ApplicationRecord
  validates :status, presence: true
  validates :customer_id, presence: true
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :merchants, through: :items
  belongs_to :customer

  enum status: { "in progress": 0, "completed": 1, "cancelled": 2}

  # def total_revenue
  #   invoice_items.joins(:item).sum("quantity * unit_price")
  # end

  def total_revenue
    # invoice_items.
  end
end
