class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates :name, :description, :merchant, presence: true
  validates :unit_price, numericality: { only_integer: true }

  enum status: [:disabled, :enabled]

  def invoice_item_quantity(invoice)
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id).quantity
  end

  def invoice_item_unit_price(invoice)
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id).unit_price
  end

  def invoice_item_status(invoice)
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id).status
  end

  def date_created
    invoices.first.created_at.strftime("%A, %B %-d, %Y")
  end

  def top_day
      invoices.select("invoices.created_at, invoice_items.quantity")
              .order(:quantity)
              .last.created_at
  end
end
