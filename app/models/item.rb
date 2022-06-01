class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true


  # def self.enabled_items
  #   where(status: 1)
  # end
  #
  # def self.disabled_items
  #   where(status: 0)
  # end
end
