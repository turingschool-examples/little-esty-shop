class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def revenue
    invoice_items.item_revenue
  end

  def self.top_5_by_revenue
  end
end


