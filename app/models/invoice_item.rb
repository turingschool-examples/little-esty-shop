class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_one :customer, through: :invoice
  has_many :transactions, -> { distinct }, through: :invoice

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true

  enum status: ["Pending", "Packaged", "Shipped"]
end
