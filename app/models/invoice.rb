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

  def invoice_items
    #  self.items.select("items.name, invoice_items.*")
    # why does above version .status give a number, andthe one bleow not?
    InvoiceItem.joins(:item).where(invoice_id: self.id)
      .select("invoice_items.*, items.name")

  end

  def expected_revenue
    InvoiceItem.where(invoice_id: self.id).group(:invoice_id)
        .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
