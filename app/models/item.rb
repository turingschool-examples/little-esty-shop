class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  enum status: ["enabled", "disabled"]

  def top_selling_date
    self.invoices
        .joins(:transactions)
        .where("transactions.result = 'success'")
        .order("invoice_items.quantity desc, invoices.created_at")
        .first
        .created_at
  end

  def invoice_item_quantity(invoice_id)
    self.invoice_items
        .where(invoice_id: invoice_id)
        .pluck(:quantity)
        .first
  end

  def invoice_item_by(invoice_id)
    self.invoice_items
        .where(invoice_id: invoice_id)
        .first
  end

  def best_discount(discounts, invoice_id)
    self.discounts
        .where("discounts.quantity_threshold <= ?", invoice_item_by(invoice_id).quantity)
        .order(percentage_discount: :desc)
        .first
  end

  def discounted_price(discounts, invoice_id)
    if best_discount(discounts, invoice_id) != nil
      discount_to_unit_price = (100 - best_discount(discounts, invoice_id).percentage_discount) / 100.0
      invoice_item_by(invoice_id).unit_price * discount_to_unit_price
    else
      invoice_item_by(invoice_id).unit_price
    end
  end
end