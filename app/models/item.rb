class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def self.item_status(status)
    where(status: status)
  end

  def item_best_day
    invoices.joins(:invoice_items)
            .select('invoices.created_at, invoice_items.quantity')
            .where("invoices.status in ('completed', 'in-progress')")
            .order('invoice_items.quantity desc')
            .first
            .created_at
            .to_date
  end
end
