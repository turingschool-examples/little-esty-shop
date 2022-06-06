class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy

  enum status: {enabled: 0, disabled: 1}

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def best_day
    invoices.joins(:invoice_items)
    .where("invoices.status = 'Completed'")
    .select('invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .group('invoices.id')
    .order("revenue desc")
    .first.created_at.to_date.to_s
  end

end

