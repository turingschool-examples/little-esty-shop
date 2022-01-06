class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  belongs_to :merchant

  validates :name, :description, :unit_price, presence: true
  enum item_status: { disabled: 0, enabled: 1}
end
