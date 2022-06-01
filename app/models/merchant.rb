class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def ready_items
    items.joins(:invoices).select('items.*')
         .where("invoice_items.status = 1")
         .group("items.id")
         .distinct
         .order(:created_at)
  end
end
