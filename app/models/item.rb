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

  def self.top_five_items
    Item.select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS product").joins(:transactions).where("transactions.result = 1").group("items.id").order(product: :desc).limit(5)
  end
end