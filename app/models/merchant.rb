class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :items

  enum status: [:enabled, :disabled]

  def favorite_customers
    transactions
    .joins(invoice: :customer)
    .where('result = ?', 1)
    .select("customers.*, count('transactions.result') as top_result")
    .group('customers.id')
    .order(top_result: :desc)
    .limit(5)
  end

  def ordered_items_to_ship
    item_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:item_id)
    Item.order(:created_at).find(item_ids)
  end

  def self.top_merchants
    joins([invoices: :transactions], :invoice_items)
    .where('result = ?', 1)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group('merchants.id')
    .order('total_revenue DESC')
    .limit(5)
  end


  def total_revenue
    invoice_items.sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
