class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item
  has_many :discounts, through: :merchants

  validates_presence_of :quantity, :unit_price, :status, :item_id, :invoice_id

  enum status: { pending: 0, packaged: 1, shipped: 2 }
  

  def self.total_revenue(merchant)
    select(:quantity, :unit_price)
    .joins(:item)
    .where("merchant_id = #{merchant}")
    .sum("invoice_items.unit_price * quantity")
  end

  def self.discounted(merchant_id)
    highest_discount = Discount.joins('INNER JOIN invoice_items ON discounts.invoice_item_id = invoice_items.id')
    .where('discounts.merchant_id = ?', merchant_id)
    .where('invoice_items.quantity >= discounts.quantity_threshhold')
    .order('discounts.quantity_threshhold DESC')
    .first

    self.joins(:item, :discounts)
    .where('items.merchant_id = ? AND discounts.merchant_id = ?', merchant_id, merchant_id) 
    .where('invoice_items.quantity >= discounts.quantity_threshhold')
    .where('discounts.quantity_threshhold = ?', highest_discount.quantity_threshhold)
    .sum('(invoice_items.unit_price * percentage) * quantity')

  end
end

"

select(:quantity, :unit_price)
.joins(:item, :discounts).where('invoice_items.quantity >= discounts.quantity_threshhold')

joins(:item, :discounts).select('quantity * invoice_items.unit_price AS price').first.price
"



