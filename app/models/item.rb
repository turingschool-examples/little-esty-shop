class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name, :description, :unit_price, :merchant_id

  enum status: { 'disabled' => 0, 'enabled' => 1}

  def change_status
    if self.status == 'disabled'
      self.enabled!
    elsif self.status == 'enabled'
      self.disabled!
    end
  end

  def self.enabled_items
    where(status: "enabled")
  end

  def self.disabled_items
    where(status: "disabled")
  end
end