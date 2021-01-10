class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :unit_price, numericality: { greater_than: 0}

  def self.all_enabled_items
    where(enabled: true)
  end

  def self.all_disabled_items
    where(enabled: false)
  end

end
