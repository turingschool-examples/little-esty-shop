class InvoiceItem < ApplicationRecord
  validates_presence_of :status, :quantity, :unit_price

  validates :quantity, numericality: true
  validates :unit_price, numericality: true

  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice

  enum status: ['pending', 'packaged', 'shipped']

  def self.items_total_revenue
    sum('quantity * unit_price')
  end
end
