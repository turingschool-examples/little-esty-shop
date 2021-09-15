class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, numericality: true

  enum enable: {
    enabled: 0,
    disabled: 1
  }

  def self.enabled_items
    where(enable: 0)
  end

  def self.disabled_items
    where(enable: 1)
  end

  def ordered_invoices
    invoices.order(:created_at)
  end
end
