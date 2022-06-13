class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, packaged: 1, shipped: 2 }
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :bulk_discounts, through: :merchants

  def get_name_from_invoice
    item.name
  end

  def display_price
    cents = unit_price
    format('%.2f', (cents / 100.0))
  end

  def merchant_discount
    bulk_discounts.where('bulk_discounts.quantity_threshold <= ?', quantity)
                  .order('bulk_discounts.quantity_threshold DESC')
                  .first
  end

  def calculate_discounted_renevue
    unit_price * quantity * (1 - merchant_discount.percent_discount)
  end

  def calculate_renevue
    (unit_price * quantity)
  end
end
