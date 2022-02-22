class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    self.invoice_items.sum(:unit_price)
  end
end
