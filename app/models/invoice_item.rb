class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: { pending: 0, packaged: 1, shipped: 2 }
  validates_numericality_of :quantity, :unit_price

  def unit_price_to_dollars
    unit_price.to_f / 100
  end
end