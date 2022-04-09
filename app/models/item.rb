class Item < ApplicationRecord
  validates :name, presence:true
  validates :description, presence:true
  validates :unit_price, presence:true, numericality: true
  validates :enabled, presence:true

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  enum enabled: {enabled: 0, disabled: 1}
end
