class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  enum status: {"in progress" => 0, completed: 1, cancelled: 2}

  def total_revenue
    invoice_items.calculate_revenue
  end

  def self.not_shipped
    joins(:invoice_items)
    .where("invoice_items.status = 0 OR invoice_items.status = 1")
    .distinct
    .order(created_at: :asc)
  end

  def date_format
    created_at.strftime("%A, %B %d, %Y")
  end

  def status_format
    status.titleize
  end
end
