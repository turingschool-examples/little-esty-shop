class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  def find_sold_price(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:unit_price)
  end

  def quantity_sold(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:quantity)
  end

  def invoice_item_status(invoice)
    invoice_items.where(invoice_id: invoice.id).pluck(:status)
  end
end
