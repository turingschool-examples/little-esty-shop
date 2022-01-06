class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  enum status: { Disabled: 0, Enabled: 1 }

  def flip_status
    if self.status == "Disabled"
      self.status = "Enabled"
    elsif self.status == "Enabled"
      self.status = "Disabled"
    end
  end

  # need to make the button dynamic
  # def opposite
  #   if self.status == "disabled"
  #     return "enable"
  #   elsif self.status == "enabled"
  #     return "disable"
  #   end
  # end
end
