class Invoice < ApplicationRecord
  enum status: { cancelled: 0, 'in progress' => 1, completed: 2 }

  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  validates :status, presence: true, inclusion: { in: Invoice.statuses.keys }

  def invoice_revenue
    invoice_items.sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def invoice_revenue_minus_discount
    invoice_items.sum do |ii|
      ii.revenue_after_discount
    end
  end


  # def find_best_applicable_discounts
  #   invoice_items.select('discounts.id')
  #   .joins(:discounts)
  #   .where('invoice_items.quantity > ?', discounts.threshold)
  # end
  #
  def invoice_item_totals
    invoice_items.select('invoice_items.id, invoice_items.item_id, invoice_items.unit_price, invoice_items.quantity, SUM(invoice_items.unit_price * invoice_items.quantity) as potential_rev' )
    .group('invoice_items.id')
  end
  #
  def find_best_applicable_discounts
    collector = []
    invoice_item_totals.each do |ii|
      ii.item.merchant.discounts.each do |disc|
        if disc.threshold <= ii.quantity
          collector << [disc.percentage, ii.id]
        end
      end
    end
    hash = collector.group_by {|array| array.last}
    x = hash.values.map { |element| element.map(&:first).max }
    y = hash.values.map { |element| element.map(&:last).max }
    result = Hash[y.zip(x)]
  end
  #
  #
  # need to match the invoice_items id with the hashes invoice_item id and apply the percent to the invoice_items potential_rev

  # def apply_discount
  #   find_best_applicable_discounts.keys.each do |ii_id|
  #     invoice_items.find_by(id: ii_id)
#
#   def total_discount
#   invoice_items.joins(:discounts)
#                 .select("invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (discounts.percentage / 1.0)) as total_discount")
#                 .where("invoice_items.quantity >= discounts.threshold")
#                 .group("invoice_items.id")
#                 .order(total_discount: :desc)
#                 .sum(&:total_discount)
# end


  # def apply_discount

  #invoices have many items via invoice items
  #if the quantity of the item on the invoice_item is at or greater than the discount threshold
  #apply the discount to the total amount of the (unit_price * quantity)
  #discount is in full integer - will need to convert to apply--do this in view like with revenue??
  #find all invoice items
  # calculate the invoice item amount

  # isolate those that have more than any threshold
  # find the biggest percentage from that list
  # multiply that against the revenue
  # return the result of that calculation

  # def total_invoice_discount
  #   invoice_items.joins(:discounts)
  #                .select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * (discounts.percentage / 100)) as total_discount')
  #                .where('invoice_items.quantity >= discounts.threshold')
  #                .group('invoice_items.id')
  #                .order('total_discount desc')
  #                .sum(??)
  #                # require "pry"; binding.pry
  # end

  # def total_invoice_discount
  #   invoice_items.joins(:discounts)
  #                 .select("invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (discounts.percentage / 100.00)) as total_discount")
  #                 .where("invoice_items.quantity >= discounts.threshold")
  #                 .group("invoice_items.id")
  #                 .order(total_discount: :desc)
  #                 require "pry"; binding.pry
                  # .sum(&:total_discount)

  # def apply_discount
  #   var = invoice_items.joins(:discounts)
  #                .where(items.merchant_id = merchants.id)
  #                .where(merchants.id = discounts.merchant_id)
  #                .select('invoice_items.id, discounts.*, max(invoice_items.unit_price * invoice_items.quantity * discounts.percentage) as disc')
  #                .where('invoice_items.quantity >= discounts.threshold')
  #                .group('invoice_items.id')
         # .select('invoice_items.id', invoice_revenue)
         # require "pry"; binding.pry
         #    .select max(discounts.percentage).where(discounts.merchant_id = items.merchant_id and discounts.threshold <= invoice_items.quantity)

         # .select('max(discounts.percentage)')
         # .where('discounts.merchant_id = items.merchant_id')
         # .where('invoice_items.quantity >= ?', 'discounts.threshold')
         # .group('invoice_items.id, items.merchant_id')
       # end



         # .where('invoice_item.quantity >= ?', max(discounts.threshold))
         # .where("invoice_item.item_id = items.id")
         # .where("items.merchant_id = merchants.id")
         # .where("merchants.id = discounts.merchant_id")
         # .group(:id)
         #       end


               # def shitty_ar
               #    items
               #    .joins(:discounts)
               #    .select('invoice_items.id, sum(invoice_items.quantity * invoice_items.unit_price)')
               #    .select max(discounts.percentage).where(discounts.merchant_id = items.merchant_id and discounts.threshold <= invoice_items.quantity)
               #    .group('invoice_items.id, items.merchant_id')
               # end
  # end


end
