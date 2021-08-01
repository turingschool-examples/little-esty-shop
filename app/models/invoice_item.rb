class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [:pending, :packaged, :shipped]

  def self.locate(invoice_id, item_id)
    where('invoice_id = ?', invoice_id).where('item_id = ?', item_id).first
  end
end
