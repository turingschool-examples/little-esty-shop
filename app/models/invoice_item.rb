class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  belongs_to :invoice
  belongs_to :item
  
  enum status: {pending: 0, packaged: 1, shipped: 2}
end
