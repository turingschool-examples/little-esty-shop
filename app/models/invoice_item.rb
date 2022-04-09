class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  belongs_to :invoices
  belongs_to :items
end
