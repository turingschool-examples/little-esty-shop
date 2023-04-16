class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  belongs_to :merchant
  enum status: ["disabled", "enabled"]

  def self.enabled_items
    Item.where(status: 1)
  end

  def self.disabled_items
    Item.where(status: 0)
  end
  
  def self.invoice_items_details(invoice)
    joins(:invoice_items).where("invoice_items.invoice_id = #{invoice.id}")
                         .select("items.*, invoice_items.quantity, invoice_items.unit_price,
                         CASE invoice_items.status 
                          WHEN '0' THEN 'Pending' 
                          WHEN '1' THEN 'Packaged' 
                          WHEN '2' THEN 'Shipped' 
                         END AS invoice_item_status")
  end
  
  def self.top_five_items
    Item.select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS product").joins(:transactions).where("transactions.result = 1").group("items.id").order(product: :desc).limit(5)
  end

  def top_day
  invoices.joins(:invoice_items)
  .where('invoice.status = 2')
  .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
  .group('invoices.created_at')
  .order('revenue desc', 'invoices.created_at desc')
  .first.created_at.strftime("%m/%d/%Y")
  end
end