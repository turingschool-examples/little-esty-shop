class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :merchant_id, presence: true, numericality: true
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true


end
