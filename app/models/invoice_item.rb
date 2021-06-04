class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates_presence_of :status
  belongs_to :invoice
  belongs_to :item

  has_many :transactions, through: :invoice

  enum status: ['pending', 'packaged', 'shipped']
end
