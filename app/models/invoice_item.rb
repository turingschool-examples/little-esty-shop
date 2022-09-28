class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: [ "pending", "packaged", "shipped" ]

  def item_name
    item.name
  end

  def ultimate_applicable_discount
    @ultimate_applicable_discount ||= item.merchant.bulk_discounts.select(:discount, :id).where("threshold <= #{self.quantity}").order(discount: :desc).first
  end

  def best_valid_discount
    if ultimate_applicable_discount
      ultimate_applicable_discount.discount
    else
      0
    end
  end

  def discount_applied
    if ultimate_applicable_discount
      ultimate_applicable_discount.id
    else
      0
    end
  end

end
