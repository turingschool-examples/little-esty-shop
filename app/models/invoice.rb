class Invoice < ApplicationRecord
  validates :status, presence: true
  enum status: [ 'in progress', 'cancelled', 'completed' ]

  belongs_to :customer

  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.find_all_invoices_not_shipped
    joins(:invoice_items)
    .where.not("invoice_items.status = ?", 2)
    .order(created_at: :desc)
    .distinct
  end

  def invoice_items(merchant_id)
    #  self.items.select("items.name, invoice_items.*")
    # why does above version .status give a number, andthe one bleow not?
    InvoiceItem.joins(item: :merchant).where(invoice_id: self.id).where('merchants.id = ?', merchant_id)
      .select("invoice_items.*, items.name")

  end

  def expected_revenue(merchant_id)
    InvoiceItem.joins(item: :merchant).where(invoice_id: self.id).group(:invoice_id).where('merchants.id = ?', merchant_id)
        .sum("invoice_items.quantity * invoice_items.unit_price")
  end 

  def item_sell_info
    self.invoice_items.includes(:item)
  end

  def revenue
    invoice_items.sum("invoice_items.unit_price * invoice_items.quantity")
  end
end
