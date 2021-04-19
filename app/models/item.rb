class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.top_five_revenue

  end

  def revenue_generated
    # self.unit_price * quantity
  end
end
