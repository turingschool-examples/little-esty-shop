class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
  validates :quantity, :unit_price, :status, presence: true
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  def self.ready_to_ship

  end
end
