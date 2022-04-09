class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  validates :merchant_id, presence: true
  belongs_to :merchant
  has_many :invoices, through: :invoice_items
  
  #enum status: {enable: 0, disable: 1}
end
