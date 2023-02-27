class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  
  enum status: ["in progress", "cancelled", "completed"]

  def find_invoiceitem_quantity(item)
    self.invoice_items.find_by(item_id: item.id).quantity
  end

  def find_invoiceitem_unitprice(item)
    self.invoice_items.find_by(item_id: item.id).unit_price
  end

  def find_invoiceitem_status(item)
    self.invoice_items.find_by(item_id: item.id).status
  end

  def get_total_revenue
    self.invoice_items.sum("unit_price")
  end

  scope :invoice_items_not_shipped, -> { joins(:invoice_items).where.not(invoice_items: {status: 2}).distinct.order(:created_at) }
end
