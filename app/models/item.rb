class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, numericality: {only_integer: true}, presence: true
  validates :status, presence: true

  enum status: {
    disabled: 0,
    enabled: 1
  }

end
