class Merchant < ApplicationRecord
  has_many :items

  def ready_items
    items.joins(:invoices).select('items.*')
         .where("invoice_items.status = 1")
         .group("items.id")
         .distinct
         .order(:created_at)
  end
  

end
