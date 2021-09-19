class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, numericality: {only_integer: true}, presence: true
  validates :status, presence: true

  enum status: {
    disabled: 0,
    enabled: 1
  }

  def amount(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id, item_id: id).quantity
  end

  def order_status(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id, item_id: id).status
  end

  def sold_price(invoice_id)
    invoice_items.find_by(invoice_id: invoice_id, item_id: id).unit_price
  end

  def ordered_invoices
    invoices.group(:id).order(:created_at)
  end
end
