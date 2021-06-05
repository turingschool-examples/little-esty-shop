class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  enum status: { disable: 0, enable: 1 }

  ###TEST###
  def self.enable_items
    where(status: 1)
  end

  def self.disable_items
    where(status: 0)
  end
end
