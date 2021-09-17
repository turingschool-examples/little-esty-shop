class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items, dependent: :destroy

  def top_5_customers
    joins(:items)
    .joins("RIGHT JOIN invoice_items ON items.id = invoice_items.item_id")
    .joins("RIGHT JOIN invoices ON invoices.id = invoice_items.invoice_id")
    .joins("RIGHT JOIN customers ON customers.id = invoices.customer_id")
    .joins("LEFT JOIN transactions ON invoices.id = transactions.invoice_id")
    .where(id: params[:merchant_id])
    .where("transactions.result = 'success'")
    .group("transactions.result, customers.id")
    .order("transactions_per DESC")
    .select("DISTINCT customers.*, count(transactions.result = 'success') as transactions_per")
    .limit(5)
  end
end
