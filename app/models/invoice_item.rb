class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: { "packaged" => 0,
                 "pending" => 1,
                 "shipped" => 2
               }

  def self.invoice_item_revenue
    sum("unit_price * quantity")
  end
end
