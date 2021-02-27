class Item < ApplicationRecord
  validates_presence_of :name, :description
  validates :unit_price, numericality: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def change_status(status)
    item_status = status
    self.save
  end
end
