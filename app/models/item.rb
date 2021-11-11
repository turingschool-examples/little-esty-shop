class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  enum status: {enabled: 0, disabled: 1}

  def self.enabled_items
    where(status: 0)
  end

  def self.disabled_items
    where(status: 1)
  end

  def amount(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id, item_id: id).quantity
  end
  
  def order_status(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id, item_id: id).status
  end

  def sold_price(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id, item_id: id).unit_price
  end
end
