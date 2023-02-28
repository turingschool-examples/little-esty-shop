class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: ["in progress", "cancelled", "completed"]

  def invoice_items_and_names
    invoice_items.joins(:item)
    .select("invoice_items.*, items.name")
  end
end
