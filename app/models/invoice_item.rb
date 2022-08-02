class InvoiceItem < ApplicationRecord
  enum status: {packaged: 0, pending: 1, shipped: 2}

  belongs_to :invoice
  belongs_to :item

  def total_revenue
    quantity * unit_price
  end
end