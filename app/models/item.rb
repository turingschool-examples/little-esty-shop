class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  
  validates :name, :description, :status, presence: true
  validates_numericality_of :unit_price, :merchant_id
  
  enum status: { disabled: 0, enabled: 1 }

  def item_invoice_id
    invoice_items.first.invoice_id
  end

  def self.enabled
    where(status: "enabled")
  end

  def self.disabled
    where(status: "disabled")
  end

  def self.top_5_by_revenue
    Item.joins(:transactions)
   .where("transactions.result = 'success'")
   .group("items.id")
   .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
   .order("revenue desc")
   .limit(5)
  end

  def top_item_day
    Item.joins(:invoices)
    .where(id: self.id, invoices: {status: 1})
    .select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) AS sales")
    .group("invoices.created_at")
    .order("sales desc")
    .limit(1)
    .first
    # .created_at
    # .strftime("%B %e, %Y")
  end
end