class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  enum status: { disabled: 0, enabled: 1}

  scope :enabled_items, -> { where(status: 1) }
  scope :disabled_items, -> { where(status: 0) }
  
  def self.top_five_items
    Item.select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS product").joins(:transactions).where("transactions.result = 1").group("items.id").order(product: :desc).limit(5)
  end
end