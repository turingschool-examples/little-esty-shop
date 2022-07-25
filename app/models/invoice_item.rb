class InvoiceItem < ApplicationRecord
  validates :status, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  validates :id, presence: true
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  belongs_to :invoice
  belongs_to :item
end
