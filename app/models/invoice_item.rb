class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price
  validates :quantity, numericality: true
  validates :unit_price, numericality: true

  belongs_to :item
  belongs_to :invoice
  has_many :discounts, through: :item

  enum status: { pending: 0, packaged: 1, shipped: 2}

  def discounts_applied
    item.merchant.discounts
    .where('item_threshold <= ?', quantity)
    .order('bulk_discount desc')
    .first
  end

  def discount_price
    if discounts_applied != nil
      (quantity * unit_price) * (1 - discounts_applied.bulk_discount)
    else
      (quantity * unit_price)
    end
  end 
end
