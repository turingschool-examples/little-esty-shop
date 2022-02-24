class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :customer
  validates_presence_of :status

  enum status: { "cancelled" => 0, "in progress" => 1, "completed" => 2  }

  def total_revenue
   invoice_items.sum("unit_price * quantity")
  end
end
