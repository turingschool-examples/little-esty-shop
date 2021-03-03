class Item < ApplicationRecord
  validates_presence_of :name,
                       :description,
                       :unit_price

                       
  enum status: [:disabled, :enabled]
                       
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.enabled_items
    where(status: 1)
  end

  def self.disabled_items
    where(status: 0)
  end

  def best_day
    Invoice
    .joins(:items)
    .where('item_id = ?', self.id)
    .select('items.*, invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) AS best_item_day')
    .group('items.id, invoices.created_at')
    .order(best_item_day: :desc)
    .first
  end
end
