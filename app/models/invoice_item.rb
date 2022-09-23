class InvoiceItem < ApplicationRecord
  enum status: [ :pending, :packaged, :shipped ]
  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item
end