class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item
  has_many :discounts, through: :merchants
  
  validates_presence_of :quantity, :unit_price, :status, :item_id, :invoice_id

  enum status: { pending: 0, packaged: 1, shipped: 2 }

  def return_discount
    self.item.merchant.discounts
    .where("discounts.threshold <= ?", self.quantity)
    .order(percentage: :desc)
    .first
  end

  def full_revenue
    quantity * unit_price
  end

  def discounted_revenue
    if self.return_discount
      discount =  self.full_revenue * (self.return_discount.percentage.to_f/100.0)
      self.full_revenue - discount
    else
      self.full_revenue
    end
  end
end