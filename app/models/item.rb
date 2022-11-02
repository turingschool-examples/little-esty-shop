class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant 

  def group_by_enabled
    items.select("name").where("status = 'Enabled'").pluck(:name)
  end
end