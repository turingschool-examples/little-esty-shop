class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates :name, :description, :merchant, presence: true
  validates :unit_price, numericality: { only_integer: true }

  # enum result: {
  #   disabled: 0,
  #   enabled: 1
  # }

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
end 
