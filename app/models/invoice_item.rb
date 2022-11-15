class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  validates_presence_of :quantity, :unit_price, :status, :item_id, :invoice_id

  enum status: { pending: 0, packaged: 1, shipped: 2 }

  def find_discount
    bulk_discounts
      .joins(:invoice_items)
      .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
      .order(percentage: :desc)
      .first
  end
end
