class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  enum active_status: { disabled: 0, enabled: 1  }

  def self.active
    where(active_status: :enabled)
  end

  def self.inactive
    where(active_status: :disabled)
  end

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
