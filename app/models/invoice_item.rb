class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity, :unit_price

  enum status: ['packaged', 'pending', 'shipped']

  validates :status, inclusion: { in: statuses.keys }
end