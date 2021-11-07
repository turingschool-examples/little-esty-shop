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
    invoices.select('invoices.created_at')
            .group('invoices.created_at')
            .order('created_at desc')
            .first
            .created_at
            .to_date
  end
end
