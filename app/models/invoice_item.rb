class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: [ "pending", "packaged", "shipped" ]

  def item_name
    item.name
  end

  def best_valid_discount
    if item.merchant.bulk_discounts.select(:discount).where("threshold <= #{self.quantity}").order(discount: :desc).first != nil
      item.merchant.bulk_discounts.select(:discount).where("threshold <= #{self.quantity}").order(discount: :desc).first.discount
    else
      0
    end
  end

  def discount_applied
    if item.merchant.bulk_discounts.select(:discount).where("threshold <= #{self.quantity}").order(discount: :desc).first != nil
      item.merchant.bulk_discounts.select(:discount, :id).where("threshold <= #{self.quantity}").order(discount: :desc).first.id
    else
      0
    end
  end

end
