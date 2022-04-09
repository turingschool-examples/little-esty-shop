class InvoiceItem < ApplicationRecord
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  belongs_to :item
  belongs_to :invoice

  enum status: {"pending" => "0", "packaged" => "1", "shipped" => "2"}
end
