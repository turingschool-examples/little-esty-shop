class Item < ApplicationRecord
  validates_presence_of :name,
                       :description,
                       :unit_price

  belongs_to :merchant

  enum status: [:disabled, :enabled]

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.enabled_items
    where(status: 1)
  end

  def self.disabled_items
    where(status: 0)
  end
end
