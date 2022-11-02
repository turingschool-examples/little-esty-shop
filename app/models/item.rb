class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, :description, :presence => true
  validates :unit_price, presence: :true, numericality: :true

  enum status: [:enabled, :disabled]

  def current_price
    unit_price / 100.0
  end

  def enable_status
    update_attribute :status, 0
  end

  def disable_status
    update_attribute :status, 1
  end
end
