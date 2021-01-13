class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: ["pending", "packaged", "shipped"]
  
  delegate :name, to: :item, prefix: true

  def self.invoice_amount
    sum('quantity * unit_price')
  end
end