class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: [ :disabled, :enabled ]

  def best_day
    invoices
    .joins(:invoice_items)
    .select('invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS best_day')
    .group(:id)
    .order('best_day desc')
    .first
  end

end
