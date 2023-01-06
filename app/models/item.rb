class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price
  validates :unit_price, numericality: { only_integer: true }

  def toggle_status
    if self.status == "Enabled"
      self.status = "Disabled"
    elsif self.status == "Disabled"
      self.status = "Enabled"
    end
  end

end