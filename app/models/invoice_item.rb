class InvoiceItem < ApplicationRecord
  validates_presence_of :status, :quantity, :unit_price

  validates :quantity, numericality: true
  validates :unit_price, numericality: true

  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice

  enum status: ['pending', 'packaged', 'shipped']

  def items_total_revenue
    # require "pry"; binding.pry
    quantity * unit_price
  end
end
