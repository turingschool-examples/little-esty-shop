class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  enum active_status: { enabled: 0, disabled: 1 }

  def quantity_purchased(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id).quantity
  end

  def price_sold(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id).unit_price
  end

  def shipping_status(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id).status
  end
  
end