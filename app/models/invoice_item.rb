class InvoiceItem < ApplicationRecord
  validates_presence_of :status, :quantity, :unit_price

  validates :quantity, numericality: true
  validates :unit_price, numericality: true

  belongs_to :item
  belongs_to :invoice

  enum status: ['pending', 'packaged', 'shipped']

  def price_in_dollars
    "$#{unit_price/100.00}"
  end
end
