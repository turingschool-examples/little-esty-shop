class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: { Disabled: 0, Enabled: 1 }

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true


end
