class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name, :description, :unit_price
  validates :unit_price, numericality: { only_integer: true }

  def toggle_status
    if self.status == "Enabled"
      self.status = "Disabled"
    elsif self.status == "Disabled"
      self.status = "Enabled"
    end
  end

  def self.find_merchant_items_by_status(merchant_id, status)
    self.where(merchant_id: merchant_id, status: status)
  end

end