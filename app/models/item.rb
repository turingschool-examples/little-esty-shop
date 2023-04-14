class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: { disabled: 0, enabled: 1 }

  def status_update(new_status)
    self.status = new_status
    self.save
  end

  def self.enabled_items
    where(status: "enabled")
  end

  def self.disabled_items
  where(status: "disabled")
  end
end
