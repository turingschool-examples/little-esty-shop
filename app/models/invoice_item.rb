class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates :quantity, presence: true
  validates :unit_price, presence: true, numericality: true

  enum status: {"Pending" => 0, "Packaged" => 1, "Shipped" => 2}

  def bulk_discount?
    discounts = item.merchant.bulk_discounts.order("quantity_threshold DESC, percentage_discount DESC")
    
    discount = discounts.where("quantity_threshold <= ?", quantity).first
    discount[:percentage_discount]
  end
end
