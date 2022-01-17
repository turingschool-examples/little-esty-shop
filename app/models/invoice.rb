class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: { "cancelled" => 0, "completed" => 1, "in progress" => 2 }

  def self.incomplete_invoices
    invoice_ids = self.where.not(status: 1).pluck(:id)
    InvoiceItem.where.not(status: "shipped").where(invoice_id: invoice_ids).order(created_at: :asc)
  end

  def total_revenue
    invoice_items
    .sum('quantity*unit_price')
  end


  def discounted_total_revenue

    merchant = Merchant.first

    discounted_total = 0

    discounts = Discount.order(:min_quantity)

    items = InvoiceItem
      .joins(item: :merchant)


    items.each do |item|
      item_total = item.quantity * item.unit_price
      discounted_total = item_total + discounted_total

      discounts.each do |discount|
        if item.quantity >= discount.min_quantity
          discounted_total = discounted_total - item_total
          item_total = item.quantity * item.unit_price * (100 - discount.percent_off) / 100
          discounted_total = discounted_total + item_total
        end
      end
    end

    return discounted_total

    # discount_items_total = InvoiceItem
    #   .joins(item: {merchant: :discounts})
    #   .distinct
    #   .where('quantity >= min_quantity')
    #   .sum('invoice_items.unit_price * invoice_items.quantity * (100 - percent_off) / 100')
    #
    #
    #
    # full_price_items_total = InvoiceItem
    #     .joins(item: {merchant: :discounts})
    #     .distinct
    #     .where('invoice_items.quantity < discounts.min_quantity')
    #     .sum('invoice_items.unit_price * invoice_items.quantity')
    
  end

end
