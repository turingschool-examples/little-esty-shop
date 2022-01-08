class Item < ApplicationRecord 
  enum status: ["enabled", "disabled"]

  belongs_to :merchant 
  has_many :invoice_items 
  has_many :invoices, through: :invoice_items 

  def self.enabled_items
    where(status: 0)
  end

  def self.disabled_items
    where(status: 1)
  end 

  def date_with_most_sales
    invoices
    .joins(:invoice_items)
    .select("invoices.created_at, invoice_items.quantity as item_quantity")
    .order(item_quantity: :desc)
    .order('invoices.created_at desc')
    .first
    .created_at
    .strftime("%m/%d/%Y")
  end
end
