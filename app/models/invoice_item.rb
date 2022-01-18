class InvoiceItem < ApplicationRecord
  belongs_to(:invoice)
  belongs_to(:item)

  enum status: { "pending" => 0, "packaged" => 1, "shipped" => 2 }

  def item_discount(invoice_item_id)
    discounts = Discount.order(:min_quantity)
    invoice_item = InvoiceItem.find(invoice_item_id)
    return_discount = nil

    discounts.each do |discount|
      if invoice_item.quantity >= discount.min_quantity
        return_discount = discount
      end
    end

    return_discount
  end

end
