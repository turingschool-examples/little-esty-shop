class InvoiceItem < ApplicationRecord
  enum status: {packaged: 0, pending: 1, shipped: 2}

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item

  def total_revenue
    quantity * unit_price
  end

  def bulk_discount_percentage
    merchant.bulk_discounts.order(percentage: :desc).where("quantity_threshold <= ?", "#{self.quantity}").first
    # max_discount = merchant.bulk_discounts.where("bulk_discounts.quantity_threshold <= #{quantity}")
    # .order(percentage: :desc)
    # .first #&.percentage.to_i / 100
    # [0, max_discount].max / 100.0  ## will return the max or zero if there isn't one
  end

  def discounted_revenue
    if bulk_discount_percentage.nil?
      total_revenue
    else
      total_revenue * (1 - (bulk_discount_percentage.percentage.to_f / 100))
    end
  end
end