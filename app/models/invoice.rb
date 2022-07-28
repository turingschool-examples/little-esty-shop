class Invoice < ApplicationRecord
  validates :status, presence: true
  validates :customer_id, presence: true
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :merchants, through: :items

  enum status: { "in progress": 0, "completed": 1, "cancelled": 2}
  
  def self.order_by_date
    order("created_at DESC")
  end

  def format_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def self.find_with_merchant(merchant)
    merchant.invoices
  end

end
