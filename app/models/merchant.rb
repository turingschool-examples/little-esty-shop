class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items

  def top_5_customers
    Merchant.joins(:items)
    .joins("RIGHT JOIN invoice_items ON items.id = invoice_items.item_id")
    .joins("RIGHT JOIN invoices ON invoices.id = invoice_items.invoice_id")
    .joins("RIGHT JOIN customers ON customers.id = invoices.customer_id")
    .joins("LEFT JOIN transactions ON invoices.id = transactions.invoice_id")
    .where(id: self.id)
    .where("transactions.result = 'success'")
    .group("transactions.result, customers.id")
    .order("transactions_per DESC")
    .select("DISTINCT customers.*, count(transactions) as transactions_per")
    .limit(5)
  end

  def items_ready_to_ship
    Item.joins(invoices: :invoice_items)
    .where("items.merchant_id = ?", self.id)
    .where(invoice_items: {status: 0})
    .select("items.*, invoices.id AS invoice_id, invoices.created_at as invoice_created_at")
    .order('invoice_created_at')
  end

end
