class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  def self.create_new_item(item_params)
    create(item_params)
  end

end
