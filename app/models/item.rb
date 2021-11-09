class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: { "Disabled" => 0, "Enabled" => 1}

  def self.enabled
    where(status: 1)
  end

  def self.disabled
    where(status: 0)
  end

  def invoice_item(invoice)
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id)
  end

  def self.top_five_items
    # joins(invoices: :transactions)
    #   .where(transactions: {result: "success"})
    #   .group(:id).select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    #   .order("total_revenue" => :desc)
    #   .limit(5)

    joins(invoices: :transactions)
      .where(transactions: {result: "success"})
      .group(:id)
      .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
      .order("total_revenue" => :desc)
      .first(5)
  end

  def invoice_item_price(invoice)
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id).unit_price
  end

  def invoice_item_quantity(invoice)
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id).quantity
  end

  def invoice_item_status(invoice)
    InvoiceItem.find_by(item_id: self.id, invoice_id: invoice.id).status
  end

end
