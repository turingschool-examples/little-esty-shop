class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def merchant_invoices
    (invoices.order(:id)).uniq
  end

  def enabled_status
    self.items.where("item_status =?", 1)
  end

  def disabled_status
    self.items.where("item_status =?", 2)
  end

  def five_most_popular_items
    # self.joins(items: [{ invoice_items: :invoices}, :transactions])
    items.joins(invoice_items: { invoice: :transactions})
        .where('transactions.result =?', 0)
        .select("merchant_id, invoice_items.item_id, items.name, sum(invoice_items.unit_price) AS total_item_sales")
        .group("merchant_id, invoice_items.item_id, items.name")
        .order("merchant_id, total_item_sales DESC")
        .limit(5)
  end
end
