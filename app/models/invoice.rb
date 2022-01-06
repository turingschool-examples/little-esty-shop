class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum status: { in_progress: 0, cancelled: 1, completed: 2}

  def customer_name
    (customer.first_name) + " " + (customer.last_name)
  end

  def merchant_items(merchant)
    Item.joins(:invoice_items).where( items: {merchant_id: merchant.id})
  end

  def merchant_invoice_items(merchant)
    InvoiceItem.joins(:item).where( items: {merchant_id: merchant.id})
  end
end
