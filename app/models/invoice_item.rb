class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def item_name
    Item.find(self.item_id).name
  end

  def invoice_date
    Invoice.find(self.invoice_id).created_at.strftime("%A, %d %B %Y")
  end
end